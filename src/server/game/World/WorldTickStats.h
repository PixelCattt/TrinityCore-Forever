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

#ifndef TRINITYCORE_WORLD_TICK_STATS_H
#define TRINITYCORE_WORLD_TICK_STATS_H

#include "Define.h"
#include <algorithm>
#include <array>
#include <atomic>
#include <chrono>
#include <cstdio>
#include <mutex>
#include <string>
#include <unordered_map>
#include <vector>

// How long the world takes to update, written to the server log once a minute (WorldTickStats.Log = 1):
//   [world_tick] 60 s: ticks=... avg=... p50=... p95=... p99=... max=... ms | maps avg/p99/max | sessions avg/max | players=... |
//   heaviest maps: <id> avg/max (<n> updates) ...
// "ticks" are world updates that ran the maps. The same scenario run on two builds (or with a switch on and off) gives the
// before/after numbers. Timing costs two clock reads per phase; with the log off nothing is collected.
namespace Trinity::WorldTickStats
{
    // 0.1 ms buckets up to 250 ms; the last bucket takes everything slower.
    class Histogram
    {
    public:
        static constexpr uint32 Buckets = 2500;

        void Add(uint64 us)
        {
            uint64 const b = us / 100;
            ++_counts[b < Buckets ? b : Buckets - 1];
            ++_n;
            _sum += us;
            _max = std::max(_max, us);
        }
        uint32 Count() const { return _n; }
        double AvgMs() const { return _n ? double(_sum) / double(_n) / 1000.0 : 0.0; }
        double MaxMs() const { return double(_max) / 1000.0; }
        double PercentileMs(double p) const
        {
            if (!_n)
                return 0.0;
            uint64 const need = uint64((p / 100.0) * double(_n) + 0.999999);
            uint64 run = 0;
            for (uint32 i = 0; i < Buckets; ++i)
            {
                run += _counts[i];
                if (run >= need)
                    return double(i + 1) / 10.0;   // upper edge of the bucket
            }
            return double(Buckets) / 10.0;
        }
        void Reset() { _counts.fill(0); _n = 0; _sum = 0; _max = 0; }

    private:
        std::array<uint32, Buckets> _counts{};
        uint32 _n = 0;
        uint64 _sum = 0;
        uint64 _max = 0;
    };

    struct MapCost
    {
        uint64 sumUs = 0;
        uint64 maxUs = 0;
        uint32 updates = 0;
    };

    struct State
    {
        std::atomic<bool> enabled{ false };
        // World thread only.
        bool mapsRan = false;   // set by MapManager::Update when its interval passed and the maps were updated
        Histogram total;
        Histogram maps;
        Histogram sessions;
        uint64 windowStartMs = 0;
        // Map threads: one entry per map id (all instances of a map summed).
        std::mutex mapLock;
        std::unordered_map<uint32, MapCost> mapCosts;
    };

    inline State& Get()
    {
        static State s;
        return s;
    }

    inline bool Enabled() { return Get().enabled.load(std::memory_order_relaxed); }

    using Clock = std::chrono::steady_clock;
    inline uint64 Since(Clock::time_point start)
    {
        return uint64(std::chrono::duration_cast<std::chrono::microseconds>(Clock::now() - start).count());
    }

    // Any map thread, after one Map::Update.
    inline void NoteMap(uint32 mapId, uint64 us)
    {
        State& s = Get();
        std::scoped_lock lock(s.mapLock);
        MapCost& c = s.mapCosts[mapId];
        c.sumUs += us;
        c.maxUs = std::max(c.maxUs, us);
        ++c.updates;
    }

    // World thread, once per World::Update that ran the maps. Returns the minute's line when one is due (empty otherwise), so the
    // caller logs it with the player counts it knows.
    inline std::string NoteTick(uint64 totalUs, uint64 mapsUs, uint64 sessionsUs, uint64 nowMs)
    {
        State& s = Get();
        s.total.Add(totalUs);
        s.maps.Add(mapsUs);
        s.sessions.Add(sessionsUs);
        if (!s.windowStartMs)
            s.windowStartMs = nowMs;
        if (nowMs - s.windowStartMs < 60000)
            return {};

        std::vector<std::pair<uint32, MapCost>> heaviest;
        {
            std::scoped_lock lock(s.mapLock);
            heaviest.assign(s.mapCosts.begin(), s.mapCosts.end());
            s.mapCosts.clear();
        }
        std::sort(heaviest.begin(), heaviest.end(), [](auto const& a, auto const& b) { return a.second.sumUs > b.second.sumUs; });

        char buf[512];
        std::snprintf(buf, sizeof(buf),
            "%u s: ticks=%u avg=%.2f p50=%.1f p95=%.1f p99=%.1f max=%.1f ms | maps avg=%.2f p99=%.1f max=%.1f | sessions avg=%.2f max=%.1f",
            uint32((nowMs - s.windowStartMs) / 1000), s.total.Count(), s.total.AvgMs(), s.total.PercentileMs(50), s.total.PercentileMs(95),
            s.total.PercentileMs(99), s.total.MaxMs(), s.maps.AvgMs(), s.maps.PercentileMs(99), s.maps.MaxMs(), s.sessions.AvgMs(),
            s.sessions.MaxMs());
        std::string line = buf;
        line += " | heaviest maps (ms per update avg/max, updates):";
        for (std::size_t i = 0; i < heaviest.size() && i < 6; ++i)
        {
            MapCost const& c = heaviest[i].second;
            std::snprintf(buf, sizeof(buf), " %u=%.2f/%.1f/%u", heaviest[i].first,
                c.updates ? double(c.sumUs) / double(c.updates) / 1000.0 : 0.0, double(c.maxUs) / 1000.0, c.updates);
            line += buf;
        }

        s.total.Reset();
        s.maps.Reset();
        s.sessions.Reset();
        s.windowStartMs = nowMs;
        return line;
    }
}

#endif
