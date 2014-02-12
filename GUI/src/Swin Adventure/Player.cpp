/**
 * @class   Player
 * @version 2.0
 * @file    Player.cpp
 * @author  Alex Cummaudo
 * @date    12 Oct 2013
 * @brief   Implements Player
 */

#include "Player.h"

// Include used classes
#include "Inventory.h"
#include "Location.h"

/**
 * @brief   Constructor for player initialises
 *          all ivars as well as parent
 */
Player::Player(string name, string desc)
       : GameObj({"me", "inventory"}, name, desc) {   // Initialise parent
        _inventory = new Inventory();                                                   // Create a new inventory for player
        _location  = new Location({"nowhere"}, "Nowhere", "The emptiness of space");    // Initialise location as nowhere
}

/**
 * @brief   The destructor for parent objects kills it child
 */
Player::~Player() {
    delete _inventory;
    delete this;
}

/**
 * @brief   Returns the full description of the
 *          player's inventory
 */
string Player::get_full_desc() {
    return _inventory->list_items();
}

/**
 * @brief   Locates a game object with the given
 *          id that is `around' the player.
 */
GameObj* Player::locate(string id) {
    // Checking the player
    if (are_you_a(id)) {
        return this;
    // Checking everything in inventory
    }
    else if (_inventory->has_item(id))
    {
        return (GameObj*)_inventory->fetch(id);
    }
    // Check the location, given the id does not
    // return a NULL
    else if (_location->locate(id) != NULL)
    {
        return _location->locate(id);
    }
    // Else out of things to check
    else {
        return NULL;
    }
}

/**
 * @brief   Returns name of player
 */
string Player::get_name()
{
    // Call parent name; this is because the interaction
    // between the interface and the class does not allow
    // for use of parent; this is a workaround to resolve that
    return GameObj::get_name();
}