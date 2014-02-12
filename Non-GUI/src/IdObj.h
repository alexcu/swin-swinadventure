/**
 * @class   Identifiable Object
 * @version 1.0
 * @file    idobj.h
 * @author  Alex Cummaudo
 * @date    19 Sept 2013
 * @brief   The base class for many idenfiable objects
 *          within the game.
 */

#ifndef __SwinAdventure__IdObj__
#define __SwinAdventure__IdObj__

// Includes and std namespace
#include <iostream>
#include <vector>
using namespace std;

// Begin class definition
class IdObj {
private:
    
    // Define ivars
    vector<string>  _ids;

public:
    
    // Define constructor
    IdObj           (vector<string> ids);
    
    // Define public methods
    bool            are_you_a(string id);
    string          first_id();

    void            add_id(string id);
    
};

#endif /* defined(__SwinAdventure__IdObj__) */
