/**
 * @class   Inventory
 * @version 1.0
 * @file    Inventory.h
 * @author  Alex Cummaudo
 * @date    20 Sept 2013
 * @brief   Defines the class for inventories
 */

#ifndef __SwinAdventure__Inventory__
#define __SwinAdventure__Inventory__

// Includes and std namespace
#include <iostream>
#include <vector>
using namespace std;

// Forward reference classes referenced in declaration
class Item;

class Inventory {
private:
    // Declare ivars
    vector<Item*>   _items;
    
public:
    // Declare public methods
    Inventory();
    ~Inventory();
    
    bool    has_item(string id);
    void    put(Item *item);
    Item*   take(string id);
    Item*   fetch(string id);
    
    string  list_items();
};

#endif /* defined(__SwinAdventure__Inventory__) */
