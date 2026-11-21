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

#include "../../src/modules/PlayerbotV2/Bot/PartyTalk.h"

using namespace Playerbot::V2::PartyTalk;

namespace
{
ReactKind Kind(std::string const& line, std::string const& bot = "aron")
{
    return ClassifyMessage(Normalize(line), bot);
}
}

TEST_CASE("Party lines in English keep their meaning", "[ClassicPartyTalk]")
{
    CHECK(Kind("ty!") == ReactKind::Thanks);
    CHECK(Kind("gz") == ReactKind::Grats);
    CHECK(Kind("ding 20") == ReactKind::Grats);
    CHECK(Kind("gg wp") == ReactKind::Grats);
    CHECK(Kind("lol") == ReactKind::Laugh);
    CHECK(Kind("wait") == ReactKind::Acknowledge);
    CHECK(Kind("rdy?") == ReactKind::Ready);
    CHECK(Kind("hi all") == ReactKind::Greeting);
    CHECK(Kind("where do we go next") == ReactKind::None);   // a question, not an order; never a zone dump from every bot
    CHECK(Kind("the weather is nice") == ReactKind::None);
    CHECK(Kind("Aron?") == ReactKind::DirectAddress);
    CHECK(Kind("where are you Aron") == ReactKind::LocationQuery);
    CHECK(Kind("gz Aron") == ReactKind::Grats);
    CHECK(Kind("pretty country") == ReactKind::None);   // whole words only
}

TEST_CASE("Party lines in Russian are understood", "[ClassicPartyTalk]")
{
    CHECK(Normalize("СПАСИБО!") == "спасибо");
    CHECK(Normalize("Ещё раз, ПОДОЖДИТЕ") == "еще раз подождите");

    CHECK(Kind("спасибо") == ReactKind::Thanks);
    CHECK(Kind("спс всем") == ReactKind::Thanks);
    CHECK(Kind("Грац!") == ReactKind::Grats);
    CHECK(Kind("ап 20") == ReactKind::Grats);
    CHECK(Kind("гг вп") == ReactKind::Grats);
    CHECK(Kind("ахаха") == ReactKind::Laugh);
    CHECK(Kind("лол") == ReactKind::Laugh);
    CHECK(Kind("жди") == ReactKind::Acknowledge);
    CHECK(Kind("го") == ReactKind::Acknowledge);
    CHECK(Kind("инк") == ReactKind::Acknowledge);
    CHECK(Kind("гтв?") == ReactKind::Ready);
    CHECK(Kind("все готовы?") == ReactKind::Ready);
    CHECK(Kind("Всем привет") == ReactKind::Greeting);
    CHECK(Kind("ку") == ReactKind::Greeting);
    CHECK(Kind("погода хорошая") == ReactKind::None);
    CHECK(Kind("купи хлеба") == ReactKind::None);   // "ку" only as a whole word

    // The bot's own name, in Latin letters inside a Russian line.
    CHECK(Kind("Aron где ты?") == ReactKind::LocationQuery);
    CHECK(Kind("где ты?") == ReactKind::None);   // not addressed: no zone dump
    CHECK(Kind("спасибо Aron") == ReactKind::Thanks);
    // A Cyrillic bot name is lowered too.
    CHECK(Kind("Борис, привет", "борис") == ReactKind::Greeting);
}

TEST_CASE("A short line is short in any language", "[ClassicPartyTalk]")
{
    CHECK(Letters("where is the bank") == 17);
    CHECK(Letters(Normalize("Где банк?")) == 8);
    CHECK(Letters(Normalize("Подскажите, где тут аукцион и банк?")) <= 48);
}

TEST_CASE("Go is an order only when it is said as one", "[ClassicPartyTalk]")
{
    for (char const* line : { "go", "ok go", "go go go", "lets go", "let's go guys, pull the next one", "go next", "we go", "Го!", "погнали" })
    {
        INFO(line);
        CHECK(SaysGo(Normalize(line)));
        CHECK(IsGoCue(Normalize(line)));
    }
    for (char const* line : { "i have to go", "gotta go", "need to go soon sorry", "where do we go next", "how do we go there",
                              "dont go yet", "i must go", "the good stuff" })
    {
        INFO(line);
        CHECK_FALSE(SaysGo(Normalize(line)));
        CHECK_FALSE(IsGoCue(Normalize(line)));
    }
}

TEST_CASE("Back from a brb is a welcome back, not a hold", "[ClassicPartyTalk]")
{
    for (char const* line : { "back", "im back", "re", "Back!", "я тут", "вернулся" })
    {
        INFO(line);
        CHECK(IsBackCue(Normalize(line)));
        CHECK_FALSE(IsPauseCue(Normalize(line)));
        CHECK(Kind(line) == ReactKind::Acknowledge);
    }
    for (char const* line : { "fall back", "back up a bit", "get back here", "назад" })
    {
        INFO(line);
        CHECK(IsPauseCue(Normalize(line)));
        CHECK_FALSE(IsBackCue(Normalize(line)));
    }
}

TEST_CASE("Russian pause, go, drink and incoming cues", "[ClassicPartyTalk]")
{
    for (char const* line : { "жди", "Подождите!", "стоп", "стойте", "назад" })
    {
        INFO(line);
        CHECK(IsPauseCue(Normalize(line)));
        CHECK_FALSE(IsGoCue(Normalize(line)));
    }
    for (char const* line : { "го", "Пулю", "погнали", "вперёд" })
    {
        INFO(line);
        CHECK(IsGoCue(Normalize(line)));
        CHECK_FALSE(IsPauseCue(Normalize(line)));
    }
    CHECK(IsDrinkCue(Normalize("пью")));
    CHECK(IsDrinkCue(Normalize("нет маны")));
    CHECK_FALSE(IsDrinkCue(Normalize("мана есть")));
    CHECK(IsIncCue(Normalize("инк!")));
    CHECK(IsIncCue(Normalize("incoming")));

    // English cues unchanged.
    CHECK(IsPauseCue(Normalize("hold on")));
    CHECK(IsGoCue(Normalize("pulling")));
    CHECK(IsDrinkCue(Normalize("oom")));
}
