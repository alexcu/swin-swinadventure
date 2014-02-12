/**
 * @class   Look Command Class
 * @version 1.0
 * @file    LookCommand.cpp
 * @author  Alex Cummaudo
 * @date    08 Oct 2013
 * @brief   Allows for the `look at object [in bag]'
 *          command.
 */

#ifndef __SwinAdventure__LookCommand__
#define __SwinAdventure__LookCommand__

// Includes and std namespace
#include <iostream>
#include <vector>
using namespace std;

// Include parent
#include "Command.h"

// Forward reference used classes
class Player;
class IHaveInventory;

class LookCommand : public Command
{
public:
    // Constructor
    LookCommand();
    
    // Override command abstract method
    virtual string execute(Player* player, vector<string> text);
    
    // Description for any invoked help command
    virtual string description();
    
private:
    // Declare private methods
    string  look_at_in(Player* player, string itemId, IHaveInventory *container);
};


#endif /* defined(__SwinAdventure__LookCommand__) */
