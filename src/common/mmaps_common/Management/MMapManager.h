/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef _MMAP_MANAGER_H
#define _MMAP_MANAGER_H

#include "Define.h"
#include "MMapDefines.h"
#include <DetourNavMeshQuery.h>
#include <atomic>
#include <memory>
#include <string_view>
#include <unordered_map>
#include <vector>

//  move map related classes
namespace MMAP
{
    struct MMapData;

    typedef std::unordered_map<uint32, std::unique_ptr<MMapData>> MMapDataSet;

    enum class LoadResult : uint8
    {
        Success,
        AlreadyLoaded,
        FileNotFound,
        VersionMismatch,
        ReadFromFileFailed,
        LibraryError
    };

    // singleton class
    // holds all all access to mmap loading unloading and meshes
    class TC_MMAPS_COMMON_API MMapManager
    {
        public:
            MMapManager();
            MMapManager(MMapManager const& other) = delete;
            MMapManager(MMapManager&& other) noexcept = delete;
            MMapManager& operator=(MMapManager const& other) = delete;
            MMapManager& operator=(MMapManager&& other) noexcept = delete;
            ~MMapManager();

            static MMapManager* instance();

            void InitializeThreadUnsafe(std::unordered_map<uint32, std::vector<uint32>> const& mapData);
            static LoadResult parseNavMeshParamsFile(std::string_view basePath, uint32 mapId, dtNavMeshParams* params, std::vector<OffMeshData>* offmeshConnections = nullptr);
            LoadResult loadMap(std::string_view basePath, uint32 mapId, uint32 instanceId, int32 x, int32 y);
            bool loadMapInstance(std::string_view basePath, uint32 meshMapId, uint32 instanceMapId, uint32 instanceId);
            void unloadMap(uint32 mapId, int32 x, int32 y);
            void unloadMap(uint32 mapId);
            void unloadMapInstance(uint32 meshMapId, uint32 instanceMapId, uint32 instanceId);

            // the returned [dtNavMeshQuery const*] is NOT threadsafe
            // (while a ScopedThreadNavMeshQuery is alive on the calling thread it is that thread's own query, see below)
            dtNavMeshQuery const* GetNavMeshQuery(uint32 meshMapId, uint32 instanceMapId, uint32 instanceId);
            dtNavMesh* GetNavMesh(uint32 mapId, uint32 instanceId);

            uint32 getLoadedTilesCount() const { return loadedTiles; }
            uint32 getLoadedMapsCount() const { return uint32(loadedMMaps.size()); }

            static bool isRebuildingTilesEnabledOnMap(uint32 mapId);

        private:
            LoadResult loadMapData(std::string_view basePath, uint32 mapId, uint32 instanceId);
            uint32 packTileID(int32 x, int32 y);

            MMapDataSet::const_iterator GetMMapData(uint32 mapId) const;
            MMapDataSet loadedMMaps;
            std::atomic<uint32> loadedTiles = 0;    // changed by several map threads (each map has its own load lock)

            std::unordered_map<uint32, uint32> parentMapData;
    };

    // While one of these is alive on a thread, GetNavMeshQuery called on that thread returns a dtNavMeshQuery that belongs to
    // the thread (same navmesh, same node pool size as the shared one) instead of the one query each map instance shares.
    // Several threads can then search paths on the same map at the same time. The navmesh itself is still shared, so a search
    // must not overlap a tile load or unload: either it runs outside the map updates, or it holds a NavMeshReadLock.
    // While the scope is active, GetNavMeshQuery and GetNavMesh take the NavMeshReadLock for their own lookup.
    class TC_MMAPS_COMMON_API ScopedThreadNavMeshQuery
    {
        public:
            ScopedThreadNavMeshQuery();
            ~ScopedThreadNavMeshQuery();
            ScopedThreadNavMeshQuery(ScopedThreadNavMeshQuery const&) = delete;
            ScopedThreadNavMeshQuery& operator=(ScopedThreadNavMeshQuery const&) = delete;

            static bool Active();

        private:
            bool _previous;
    };

    // Searches from a thread that is not a map update thread (bot logic threads) run while the map threads load and unload
    // navmesh tiles. Every tile or mesh change takes the tile lock exclusively (MMapManager does it itself; code that swaps
    // tiles on its own, like the dynamic tile builder, holds a NavMeshTileChangeLock). Such a search holds a NavMeshReadLock
    // (the same lock, shared) for its whole length, together with a ScopedThreadNavMeshQuery. A map thread searching its own
    // map needs neither: its own tile changes happen between its own searches.
    // Nested read locks on one thread are counted, only the outermost one locks.
    class TC_MMAPS_COMMON_API NavMeshReadLock
    {
        public:
            NavMeshReadLock();
            ~NavMeshReadLock();
            NavMeshReadLock(NavMeshReadLock const&) = delete;
            NavMeshReadLock& operator=(NavMeshReadLock const&) = delete;
    };

    class TC_MMAPS_COMMON_API NavMeshTileChangeLock
    {
        public:
            NavMeshTileChangeLock();
            ~NavMeshTileChangeLock();
            NavMeshTileChangeLock(NavMeshTileChangeLock const&) = delete;
            NavMeshTileChangeLock& operator=(NavMeshTileChangeLock const&) = delete;
    };
}

#endif
