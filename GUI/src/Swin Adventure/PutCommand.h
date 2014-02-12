//
//  PutCommand.h
//  SwinAdventure
//
//  Created by Alex on 8/11/2013.
//  Copyright (c) 2013 Alex Cummaudo. All rights reserved.
//

#ifndef __SwinAdventure__PutCommand__
#define __SwinAdventure__PutCommand__

// Includes and std namespace
#include <iostream>
#include <vector>
using namespace std;

// Include parent
#include "Command.h"

// Forward reference used classes
class Player;
class IHaveInventory;
class Item;

class PutCommand : public Command
{
public:
    // Constructor
    PutCommand();
    
    // Override command abstract method
    virtual string execute(Player* player, vector<string> text);
    
    // Description for any invoked help command
    virtual string description();
    
private:
    // Put ___ in ____
    virtual string put_something_in(Player* player, string itemId, IHaveInventory *container);
};

#endif /* defined(__SwinAdventure__PutCommand__) */
