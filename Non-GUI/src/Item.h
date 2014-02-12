/**
 * @class   Item
 * @version 1.0
 * @file    Item.h
 * @author  Alex Cummaudo
 * @date    20 Sept 2013
 * @brief   Defines the class for items
 */

#ifndef __SwinAdventure__Item__
#define __SwinAdventure__Item__

// Includes and std namespace
#include <iostream>
#include <vector>
using namespace std;

// Include parent classes
#include "GameObj.h"

class Item : public GameObj {
    
public:
    Item(vector<string> ids, string name, string desc);
    
};

#endif /* defined(__SwinAdventure__Item__) */
