/**
 * @class   Location
 * @version 2.0
 * @file    Location.h
 * @author  Alex Cummaudo
 * @date    12 Oct 2013
 * @brief   Defines the class locations players can go to
 */

#ifndef __SwinAdventure__Location__
#define __SwinAdventure__Location__

#include <iostream>

// Include parent class
#include "GameObj.h"

// Include interfaces
#include "IHaveInventory.h"

// Forward delcare classes used
class Inventory;
class Path;

class Location : public GameObj, public IHaveInventory
{
public:
    // Constructor / destructor
    Location    (vector<string> ids, string name, string desc);
    ~Location   ();
    
    // Implements interface
    virtual     GameObj*    locate(string id);
    virtual     string      get_name();
    
    // Other methods
    Inventory*  get_inventory();
    void        add_path(Path* path);
    virtual     string      get_full_description();
    
private:
    Inventory*  _inventory;
    Inventory*  _paths;
};

#endif /* defined(__SwinAdventure__Location__) */
