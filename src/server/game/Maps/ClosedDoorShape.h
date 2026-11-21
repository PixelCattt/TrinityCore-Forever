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

#ifndef TRINITY_CLOSED_DOOR_SHAPE_H
#define TRINITY_CLOSED_DOOR_SHAPE_H

#include "Define.h"
#include "PhaseShift.h"
#include <G3D/AABox.h>
#include <G3D/Matrix3.h>
#include <G3D/Ray.h>
#include <G3D/Vector3.h>
#include <memory>
#include <vector>

namespace VMAP
{
    class WorldModel;
}

// A closed door's collision as its map last published it (Map::GetPublishedClosedDoors): the walls a path searched off the map
// thread keeps clear of (PathGenerator::ClosedDoorTest::Published). The door's own model can change or go while such a search
// runs; this copy cannot, and the model data it shares never changes once loaded.
struct TC_GAME_API ClosedDoorShape
{
    std::shared_ptr<VMAP::WorldModel const> Model;
    G3D::AABox Bound;
    G3D::Matrix3 InvRot;
    G3D::Vector3 Pos;
    float InvScale = 1.0f;
    float Scale = 1.0f;
    PhaseShift Phase;
    uint32 Entry = 0;
    // Those who plan off the map thread open this door themselves when they reach it (Map::SetClosedDoorPlanThroughCheck), so their
    // plans run through it as before; the move itself still stops at it until it is open.
    bool PlanThrough = false;

    // GameObjectModel::IntersectRay on the copy.
    bool IntersectRay(G3D::Ray const& ray, float& maxDist, PhaseShift const& phaseShift) const;
};

// Map::FindClosedDoorOnSegment against published doors, leaving out those planned through.
TC_GAME_API bool FindClosedDoorOnSegment(std::vector<ClosedDoorShape> const& doors, PhaseShift const& phaseShift, G3D::Vector3 const& from,
    G3D::Vector3 const& to, G3D::Vector3& hit);

#endif // TRINITY_CLOSED_DOOR_SHAPE_H
