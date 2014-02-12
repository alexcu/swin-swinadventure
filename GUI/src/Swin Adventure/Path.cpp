/**
 * @class   Path
 * @version 1.0
 * @file    Path.cpp
 * @author  Alex Cummaudo
 * @date    16 Oct 2013
 * @brief   Implements Path
 */

// Include my interface
#include "Path.h"

// Include interfaces of classes used
#include "Player.h"
#include "Location.h"

/**
 * @brief   Constructor to implement parent and initalise dest
 */
Path::Path(vector<string> ids, string name, string desc, Location *destination, bool bidirectional)
    :GameObj(vector<string> (ids), name, desc)
{
    _destination = destination;
    _bidirectional = bidirectional;
}

/**
 * @brief   Moves the player to this destination,
 *          and adds this path to the destination
 *          where bidirectional paths occur
 */
void Path::move(Player *p)
{
    // Where bidirectional
    if (_bidirectional)
    {
        // Add this path as a way back to the
        // original location
        _destination->add_path(this);
        
        // Set the new destination of this path
        // to wherever the player is coming from
        Location* wayBack = p->get_location();
        
        // Move the player to the new destination
        p->set_location(_destination);
        
        // Set the destination to this path as
        // the way back
        _destination = wayBack;

    }
    else
    {
        // Move the player to the new destination
        // (and thats it)
        p->set_location(_destination);

    }
}