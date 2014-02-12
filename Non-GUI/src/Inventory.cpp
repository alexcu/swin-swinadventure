/**
 * @class   Inventory
 * @version 1.0
 * @file    Inventory.cpp
 * @author  Alex Cummaudo
 * @date    20 Sept 2013
 * @brief   Implements Inventory
 */

#include "Inventory.h"
#include <sstream>

// Include classes used
#include "Item.h"

/**
 * @brief   Constructor for Inventory initalises fields
 */
Inventory::Inventory() {
    // No fields to initialise (_items initially blank) just having here for me to
    // remember.
}

/**
 * @brief   Destructor for Inventory deletes all items
 */
Inventory::~Inventory() {
    for (int i = 0; i < _items.size(); i++) {
        delete _items[i] ;
    }
    _items.clear();
}

/**
 * @brief   Checks if the inventory contains a certain
 *          kind of item
 */
bool Inventory::has_item(string id) {
    // Fetch an item with this id; where it returns
    // a NULL return false
    if (fetch(id) != NULL)  { return true;  }
    else                    { return false; }
}

/**
 * @brief   Adds an item to _items
 */
void Inventory::put(Item *item) {
    _items.push_back(item);
}

/**
 * @brief   Removes an item from _items
 */
Item* Inventory::take(string id) {
    // Get the itemToTake by using fetch
    Item* itemToTake = fetch(id);
    // Remove the itemToTake from _items
    // since taking it removes it
    _items.erase(remove_if(_items.begin(),
                           _items.end(),
                           [&id](Item *i){ return i->are_you_a(id); }));
    // Return the itemToTake
    return itemToTake;
}

/**
 * @brief   Returns an item from _items without removing it
 */
Item* Inventory::fetch(string id) {
    // Use find_if with lamda expression to find item with matching id
    auto fetchItm = find_if(_items.begin(),
                            _items.end(),
                            [&id](Item *i){ return i->are_you_a(id); });
    if (fetchItm != _items.end()) {
        // Found something
        return *fetchItm;
    } else {
        // Found nothing
        return NULL;
    }
}

/**
 * @brief   Returns a list of all the items contained in this
 *          inventory
 */
string  Inventory::list_items() {
    ostringstream stream;
    for (int i = 0; i < _items.size(); i++) {
        stream << _items[i]->get_name() << endl;
    }
    string result;
    result = stream.str();
    return result;
}