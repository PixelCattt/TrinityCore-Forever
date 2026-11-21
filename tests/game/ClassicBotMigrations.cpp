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
#include "tc_catch2.h"

#include "../../src/modules/PlayerbotV2/Persistence/MigrationLint.h"

#include <filesystem>
#include <fstream>
#include <sstream>
#include <string>

using Playerbot::MigrationLint::SharedTokenOutsideShared;

TEST_CASE("Bot migrations: {SHARED} only after a shared target line", "[BotMigrations]")
{
    CHECK(SharedTokenOutsideShared("DELETE FROM {SHARED}.t;\n") == 1);
    CHECK(SharedTokenOutsideShared("-- Purpose: about {SHARED} tables\n-- @target: shared\nDELETE FROM {SHARED}.t;\n") == 0);
    CHECK(SharedTokenOutsideShared("-- @target: shared\nDELETE FROM {SHARED}.t;\n-- @target: characters\nUPDATE {SHARED}.t SET a = 1;\n") == 4);
    CHECK(SharedTokenOutsideShared("--   @target:   SHARED  \r\nDELETE FROM {SHARED}.t;\r\n") == 0);
    CHECK(SharedTokenOutsideShared("CREATE TABLE x (a INT);\n") == 0);
}

// Every migration the server will run: a {SHARED} name in a character-database statement stopped the server at startup
// (core-0041 on the dev realm, 2026-11-17).
TEST_CASE("Bot migrations: every shipped migration names {SHARED} only for the shared schema", "[BotMigrations]")
{
    namespace fs = std::filesystem;
    fs::path const dir = fs::path(TC_SOURCE_DIR) / "sql" / "playerbot_v2";   // TC_SOURCE_DIR comes from CMake (tests/CMakeLists.txt)
    REQUIRE(fs::is_directory(dir));
    size_t files = 0;
    for (fs::directory_entry const& e : fs::directory_iterator(dir))
    {
        if (!e.is_regular_file() || e.path().extension() != ".sql")
            continue;
        std::ifstream in(e.path(), std::ios::binary);
        std::stringstream ss;
        ss << in.rdbuf();
        INFO(e.path().filename().string());
        CHECK(SharedTokenOutsideShared(ss.str()) == 0);
        ++files;
    }
    CHECK(files > 30);
}
