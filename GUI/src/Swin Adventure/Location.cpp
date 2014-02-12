/**
 * @class   Location
 * @version 2.0
 * @file    Location.cpp
 * @author  Alex Cummaudo
 * @date    12 Oct 2013
 * @brief   Implements Location
 */

// Include my interface
#include "Location.h"

// Include used classes
#include "Inventory.h"
#include "Player.h"
#include "Path.h"
#include <sstream>

/**
 * @brief   Constructor to implement parent and initalise inv
 */
Location::Location(vector<string> ids, string name, string desc)
         :GameObj(vector<string> (ids), name, desc)
{
    _inventory = new Inventory();
    _paths     = new Inventory();
}

/**
 * @brief   The destructor for parent objects kills it child
 */
Location::~Location()
{
    delete _inventory;
}

/**
 * @brief   Locates a game object with the given
 *          id that is `around' the location.
 */
GameObj* Location::locate(string id) {
    // Checking this location
    if (are_you_a(id))
    {
        return this;
    
    }
    // Checking everything in my inventory
    else if (_inventory->has_item(id))
    {
        return (GameObj*)_inventory->fetch(id);
    }
    // Checking for paths I have with that id
    else if (_paths->has_item(id))
    {
        return (GameObj*)_paths->fetch(id);
    }
    // Else out of things to check
    else {
        return NULL;
    }
}

/**
 * @brief   Returns name of this location
 */
string Location::get_name()
{
    // Call parent name; this is because the interaction
    // between the interface and the class does not allow
    // for use of parent; this is a workaround to resolve that
    return GameObj::get_name();
}

/**
 * @brief   Returns the inventory
 */
Inventory* Location::get_inventory()
{
    return _inventory;
}

/**
 * @brief   Describes the current location (items and paths)
 */
string Location::get_full_description()
{
    stringstream desc;
    desc << "This is " << this->get_name() << " - " << GameObj::get_full_desc() << endl << endl;
    desc << "Items: " << endl << "-----" << endl << _inventory->list_items() << endl;
    desc << "Paths: " << endl << "-----" << endl << _paths->list_items() << endl;
    return desc.str();
}

/**
 * @brief   Adds a new path to my inventory of
 *          paths (only where this path doesn't
 *          already exist to prevent duplicates)
 */
void Location::add_path(Path *path)
{
    // Where paths of this path do not already exist
    if (!_paths->has_item(path->first_id()))
    {
        // Polymorphism At Work! ( it worked! :D )
        // =======================================
        // Both item and path are inherit from the
        // GameObj class; we can correctly cast
        // a Path type into an Item type since they
        // are part of the same family of subclasses
        // from the GameObj class!
        
        _paths->put((Item*)path);
    }
}