/**
 * @class   Identifiable Object
 * @version 1.0
 * @file    IdObj.cpp
 * @author  Alex Cummaudo
 * @date    19 Sept 2013
 * @brief   Implements IdObj
 */

#include "IdObj.h"

/**
 * @brief   The constructor for an identifiable object
 *          initialises the _id vector by adding all the
 *          argument strings to the _id vector.
 */
IdObj::IdObj(vector<string> ids) {
    for (int i = 0; i < ids.size(); i++) {
        this->add_id(ids[i]);   // Adds it using add_id method (ensures lowercase)
    }
}

/**
 * @brief   Checks if the id passed is within the _ids
 *          collection
 */
bool IdObj::are_you_a(string id) {
    // Get the id
    auto findId = find_if(_ids.begin(), _ids.end(),
                          [id](string i) { return i == id; } );
    
    if (findId != _ids.end()) {
        // Match found
        return true;
    } else {
        // No match found
        return false;
    }
}

/**
 * @brief   Returns the first id in the _ids collection
 */
string IdObj::first_id() {
    if (!(_ids.empty()))    { return _ids[0]; } // If not empty, return first element
    else                    { return "";      } // else return an empty string.
}

/**
 * @brief   Adds an identifier to the _ids collection, first
 *          converting it all to lower case
 */
void IdObj::add_id(string id) {
    transform(id.begin(),   // Transform starting from the beginning of the string
              id.end(),     // to the end of the string
              id.begin(),   // Output replaces from start of string
              ::tolower);   // Everything is lowered to lowercase
    _ids.push_back(id);     // Push the lower-case id to _ids
}