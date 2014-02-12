/**
 * @class   Player
 * @version 2.0
 * @file    Player.h
 * @author  Alex Cummaudo
 * @date    12 Oct 2013
 * @brief   Defines the class for player objects
 */

#ifndef __SwinAdventure__Player__
#define __SwinAdventure__Player__

// Include parent class
#include "GameObj.h"

// Include interfaces
#include "IHaveInventory.h"

// Forward reference classes used
class Inventory;
class Location;

class Player : public GameObj, public IHaveInventory {
private:
    // Declare ivars
    Inventory*  _inventory;
    Location*   _location;
    
public:
    // Declare methods
    Player      (string name, string desc);
    virtual     ~Player();
    
    // Implements interface
    virtual     GameObj*    locate(string id);
    virtual     string      get_name();
    
    // Override methods from parent
    virtual     string      get_full_desc();
    
    // Properties
    Inventory*  get_inventory() { return _inventory; };
    Location*   get_location() { return _location; }
    void        set_location(Location *loc) { _location = loc; }
};

#endif /* defined(__SwinAdventure__Player__) */