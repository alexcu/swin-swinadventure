/**
 * @class   Game Object
 * @version 1.0
 * @file    GameObj.cpp
 * @author  Alex Cummaudo
 * @date    20 Sept 2013
 * @brief   Implements GameObj
 */

#include <sstream>

#include "GameObj.h"

/**
 * @brief   Constructor for a game object intialises 
 *          the fields required for each GameObj
 */
GameObj::GameObj(vector<string> ids, string name, string desc)
    : IdObj(vector<string>(ids)) { // Explicitly intialise GameObj's parent with the ids passed
    
    // Initialise ivars
    _name           = name;
    _description    = desc;

}

/**
 * @brief   Returns the name
 */
string GameObj::get_name() {
    return _name;
}

/**
 * @brief   Returns the name and the first id of the
 *          game object
 */
string GameObj::get_short_desc() {
    ostringstream string;
    string << _name << " (" << this->first_id() << ")";
    return string.str();
}