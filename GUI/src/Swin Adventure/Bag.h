/**
 * @class   Bags
 * @version 1.0
 * @file    bag.h
 * @author  Alex Cummaudo
 * @date    06 Oct 2013
 * @brief   Class that allows creation of bags of
 *          items
 */

#ifndef __SwinAdventure__Bag__
#define __SwinAdventure__Bag__

// Includes and std namespace
#include <iostream>
#include <vector>
using namespace std;

// Include parent class
#include "Item.h"

// Include interfaces
#include "IHaveInventory.h"

// Forward reference classes referenced in declaration
class GameObj;
class Inventory;

class Bag : public Item, public IHaveInventory {
public:
    // Declare Constructor
    Bag(vector<string> ids, string name, string desc);
    
    // Implements interface
    virtual     GameObj*    locate(string id);
    virtual     string      get_name();
    
    // Declare public methods
    string      get_full_desc();
    Inventory*  get_inventory();
    
private:
    // Declare Fields
    Inventory*  _inventory;
};

#endif /* defined(__SwinAdventure__Bag__) */
