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

#define CATCH_CONFIG_ENABLE_CHRONO_STRINGMAKER
#include "tc_catch2.h"

#include "Config.h"
#include <boost/filesystem.hpp>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <map>
#include <string>

std::string CreateConfigWithMap(std::map<std::string, std::string> const& map)
{
    auto mTempFileRel = boost::filesystem::unique_path("deleteme.ini");
    auto mTempFileAbs = boost::filesystem::temp_directory_path() / mTempFileRel;
    std::ofstream iniStream;
    iniStream.open(mTempFileAbs.c_str());

    iniStream << "[test]\n";
    for (auto const& itr : map)
        iniStream << itr.first << " = " << itr.second << "\n";

    iniStream.close();

    return mTempFileAbs.string();
}

TEST_CASE("Environment variables", "[Config]")
{
    std::map<std::string, std::string> config;
    config["Int.Nested"] = "4242";
    config["lower"] = "simpleString";
    config["UPPER"] = "simpleString";
    config["SomeLong.NestedNameWithNumber.Like1"] = "1";

    auto filePath = CreateConfigWithMap(config);

    std::string err;
    REQUIRE(sConfigMgr->LoadInitial(filePath, std::vector<std::string>(), err));
    REQUIRE(err.empty());

    SECTION("Nested int")
    {
        REQUIRE(sConfigMgr->GetIntDefault("Int.Nested", 10) == 4242);

        putenv(strdup("TC_INT_NESTED=8080"));
        REQUIRE(!sConfigMgr->OverrideWithEnvVariablesIfAny().empty());
        REQUIRE(sConfigMgr->GetIntDefault("Int.Nested", 10) == 8080);
    }

    SECTION("Simple lower string")
    {
        REQUIRE(sConfigMgr->GetStringDefault("lower", "") == "simpleString");

        putenv(strdup("TC_LOWER=envstring"));
        REQUIRE(!sConfigMgr->OverrideWithEnvVariablesIfAny().empty());
        REQUIRE(sConfigMgr->GetStringDefault("lower", "") == "envstring");
    }

    SECTION("Simple upper string")
    {
        REQUIRE(sConfigMgr->GetStringDefault("UPPER", "") == "simpleString");

        putenv(strdup("TC_UPPER=envupperstring"));
        REQUIRE(!sConfigMgr->OverrideWithEnvVariablesIfAny().empty());
        REQUIRE(sConfigMgr->GetStringDefault("UPPER", "") == "envupperstring");
    }

    SECTION("Long nested name with number")
    {
        REQUIRE(sConfigMgr->GetFloatDefault("SomeLong.NestedNameWithNumber.Like1", 0) == 1.0f);

        putenv(strdup("TC_SOME_LONG_NESTED_NAME_WITH_NUMBER_LIKE_1=42"));
        REQUIRE(!sConfigMgr->OverrideWithEnvVariablesIfAny().empty());
        REQUIRE(sConfigMgr->GetFloatDefault("SomeLong.NestedNameWithNumber.Like1", 0) == 42.0f);
    }

    SECTION("String that not exist in config")
    {
        putenv(strdup("TC_UNIQUE_STRING=somevalue"));
        REQUIRE(sConfigMgr->GetStringDefault("Unique.String", "") == "somevalue");
    }

    SECTION("Int that not exist in config")
    {
        putenv(strdup("TC_UNIQUE_INT=100"));
        REQUIRE(sConfigMgr->GetIntDefault("Unique.Int", 1) == 100);
    }

    SECTION("Not existing string")
    {
        REQUIRE(sConfigMgr->GetStringDefault("NotFound.String", "none") == "none");
    }

    SECTION("Not existing int")
    {
        REQUIRE(sConfigMgr->GetIntDefault("NotFound.Int", 1) == 1);
    }

    std::remove(filePath.c_str());
}

namespace
{
    std::string WriteTempConfig(std::string const& text)
    {
        auto path = boost::filesystem::temp_directory_path() / boost::filesystem::unique_path("deleteme-%%%%-%%%%.conf");
        std::ofstream stream(path.c_str());
        stream << text;
        return path.string();
    }
}

// Drop-in files (worldserver.conf.d/*.conf, modules) are merged into the main config by LoadAdditionalFile. A file without a
// [section] header lost every key: its first key was read as the section.
TEST_CASE("Drop-in config files", "[Config]")
{
    std::string mainFile = WriteTempConfig("[worldserver]\nMain.Key = 1\n");
    std::string err;
    REQUIRE(sConfigMgr->LoadInitial(mainFile, std::vector<std::string>(), err));

    SECTION("with one section header")
    {
        std::string dropIn = WriteTempConfig("[playerbot]\nDropIn.Sectioned = 7\nDropIn.SectionedToo = 8\n");
        REQUIRE(sConfigMgr->LoadAdditionalFile(dropIn, false, err));
        REQUIRE(sConfigMgr->GetIntDefault("DropIn.Sectioned", 0) == 7);
        REQUIRE(sConfigMgr->GetIntDefault("DropIn.SectionedToo", 0) == 8);
        std::remove(dropIn.c_str());
    }

    SECTION("without a section header")
    {
        std::string dropIn = WriteTempConfig("DropIn.Flat = 5\nDropIn.FlatToo = 6\n");
        REQUIRE(sConfigMgr->LoadAdditionalFile(dropIn, false, err));
        REQUIRE(sConfigMgr->GetIntDefault("DropIn.Flat", 0) == 5);
        REQUIRE(sConfigMgr->GetIntDefault("DropIn.FlatToo", 0) == 6);
        std::remove(dropIn.c_str());
    }

    SECTION("with one key and no section header")
    {
        std::string dropIn = WriteTempConfig("DropIn.Single = 9\n");
        REQUIRE(sConfigMgr->LoadAdditionalFile(dropIn, false, err));
        REQUIRE(sConfigMgr->GetIntDefault("DropIn.Single", 0) == 9);
        std::remove(dropIn.c_str());
    }

    SECTION("with two section headers")
    {
        std::string dropIn = WriteTempConfig("[first]\nDropIn.First = 3\n[second]\nDropIn.Second = 4\n");
        REQUIRE(sConfigMgr->LoadAdditionalFile(dropIn, false, err));
        REQUIRE(sConfigMgr->GetIntDefault("DropIn.First", 0) == 3);
        REQUIRE(sConfigMgr->GetIntDefault("DropIn.Second", 0) == 4);
        std::remove(dropIn.c_str());
    }

    REQUIRE(sConfigMgr->GetIntDefault("Main.Key", 0) == 1);
    std::remove(mainFile.c_str());
}
