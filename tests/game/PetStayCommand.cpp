#include "tc_catch2.h"
#include "CharmInfo.h"
#include "Creature.h"

// "Move To" must leave a pet in the same mode as "Stay" at the new spot. PetAI only knew COMMAND_STAY and
// COMMAND_FOLLOW, so after Move To the pet refused every target, even an explicit Attack, until it was re-summoned.

TEST_CASE("Stay and Move To are stay commands; Follow, Attack and Abandon are not", "[PetStayCommand]")
{
    STATIC_CHECK(IsPetStayCommand(COMMAND_STAY));
    STATIC_CHECK(IsPetStayCommand(COMMAND_MOVE_TO));
    STATIC_CHECK_FALSE(IsPetStayCommand(COMMAND_FOLLOW));
    STATIC_CHECK_FALSE(IsPetStayCommand(COMMAND_ATTACK));
    STATIC_CHECK_FALSE(IsPetStayCommand(COMMAND_ABANDON));
}

TEST_CASE("A pet's charm info reports a stay command after Stay or Move To", "[PetStayCommand]")
{
    Creature pet(false);
    CharmInfo charmInfo(&pet);

    // New pets start on Follow.
    CHECK_FALSE(charmInfo.HasStayCommand());

    charmInfo.SetCommandState(COMMAND_MOVE_TO);
    CHECK(charmInfo.HasStayCommand());
    CHECK_FALSE(charmInfo.HasCommandState(COMMAND_STAY));

    charmInfo.SetCommandState(COMMAND_STAY);
    CHECK(charmInfo.HasStayCommand());

    charmInfo.SetCommandState(COMMAND_FOLLOW);
    CHECK_FALSE(charmInfo.HasStayCommand());
}

TEST_CASE("Move To stores the clicked spot as the stay position", "[PetStayCommand]")
{
    // The handler cannot read the spot from the spline: the point movement it just queued has not started yet.
    Creature pet(false);
    CharmInfo charmInfo(&pet);

    charmInfo.SetStayPosition(-8913.5f, 554.25f, 93.75f);
    float x = 0.0f, y = 0.0f, z = 0.0f;
    charmInfo.GetStayPosition(x, y, z);
    CHECK(x == -8913.5f);
    CHECK(y == 554.25f);
    CHECK(z == 93.75f);
}
