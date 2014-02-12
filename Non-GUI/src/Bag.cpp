/**
 * @class   Bags
 * @version 1.0
 * @file    bag.m
 * @author  Alex Cummaudo
 * @date    06 Oct 2013
 * @brief   Implements bags
 */

#include "Bag.h"
#include <sstream>

// Import used classes
#include "GameObj.h"
#include "Inventory.h"

/**
 * @brief   Constructor for a bag object intialises
 *          the fields required for its parent, Item
 */
Bag::Bag(vector<string> ids, string name, string desc)
    : Item(vector<string> (ids), name, desc) // Initialise Parent
{
    // Initialise _inventory
    _inventory = new Inventory();
}

/**
 * @brief   Locates a game object inside the bag with
 *          the given id
 */
GameObj* Bag::locate(string id)
{
    // Returns the bag itself if id is the id of a bag
    if (this->are_you_a(id))            { return this; }
    
    // Returns an item in the inventory if it exists
    else if (_inventory->has_item(id))  { return _inventory->fetch(id); }
    
    // Returns nothing if non-existing id
    else return NULL;
}

/**
 * @brief   Description returns everything in the 
 *          inventory
 */
string Bag::get_full_desc() {
    ostringstream string;
    string << "In the " << this->get_name() << " you see:" << endl << _inventory->list_items() << endl;
    return string.str();
}

/**
 * @brief   Returns the inventory inside the bag
 */
Inventory* Bag::get_inventory()
{
    return _inventory;
}

/**
 * @brief   Returns name of bag
 */
string Bag::get_name()
{
    // Call parent name; this is because the interaction
    // between the interface and the class does not allow
    // for use of parent; this is a workaround to resolve that
    return Item::get_name();
}