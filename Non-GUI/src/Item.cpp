/**
 * @class   Item
 * @version 1.0
 * @file    Item.cpp
 * @author  Alex Cummaudo
 * @date    20 Sept 2013
 * @brief   Implements Item
 */

#include "Item.h"

/**
 * @brief   Constructs a new item by initialising
 *          its parent
 */
Item::Item(vector<string> ids, string name, string desc)
    : GameObj(vector<string> (ids), name, desc) { // Explicitly initialise parent with passed args
}

/**
 * @brief   Destructor for GameObj must destroy all
 *          item children first
 */
GameObj::~GameObj() {}