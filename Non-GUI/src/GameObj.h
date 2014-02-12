/**
 * @class   Game Object
 * @version 1.0
 * @file    GameObj.h
 * @author  Alex Cummaudo
 * @date    20 Sept 2013
 * @brief   Defines the class for a new game object, a kind of
 *          identifiable object, that allows for the definition
 *          of all the objects within the game which the player
 *          interacts with
 */

#ifndef __SwinAdventure__GameObj__
#define __SwinAdventure__GameObj__

// Include parent classes
#include "IdObj.h"

class GameObj : public IdObj {
private:
    // Declare ivars
    string  _description;
    string  _name;
public:
    // Declare public methods
    GameObj (vector<string> ids, string name, string desc);
    string  get_name();
    string  get_short_desc();
    
    // Declare abstract methods
    virtual ~GameObj();
    virtual string  get_full_desc() { return _description; };
};


#endif /* defined(__SwinAdventure__GameObj__) */
