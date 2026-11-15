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

#ifndef TRINITYCORE_CONFIG_BASE_FILE_H
#define TRINITYCORE_CONFIG_BASE_FILE_H

#include "Define.h"
#include <string>

namespace Trinity::Config
{
    // Loads a config file that sits between the main file and the additional files (worldserver.conf.d): its keys beat the main
    // file, and every additional file beats it, even one loaded before it. For a module's own config file (playerbot.conf), so
    // the override directory stays the place that wins. sConfigMgr->Reload keeps it in the same place. Loading the same file
    // again only reads it again. (Kept out of Config.h, which nearly every file includes.)
    TC_COMMON_API bool LoadBaseFile(std::string file, std::string& error);
}

#endif // TRINITYCORE_CONFIG_BASE_FILE_H
