/**
 * @class   Take Command Class
 * @version 1.0
 * @file    TakeCommand.cpp
 * @author  Alex Cummaudo
 * @date    08 Nov 2013
 * @brief   Allows for the `take <object> [from bag]'
 *          command.
 */

#ifndef __SwinAdventure__TakeCommand__
#define __SwinAdventure__TakeCommand__

#include <iostream>

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

class TakeCommand : public Command
{
public:
    // Constructor
    TakeCommand();
    
    // Override command abstract method
    virtual string execute(Player* player, vector<string> text);
    
    // Description for any invoked help command
    virtual string description();
    
private:
    // Take ___ from ____
    virtual string take_something_in(Player* player, string itemId, IHaveInventory *container);
};
#endif /* defined(__SwinAdventure__TakeCommand__) */
