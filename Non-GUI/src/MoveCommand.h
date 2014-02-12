/**
 * @class   Move Command Class
 * @version 1.0
 * @file    MoveCommand.h
 * @author  Alex Cummaudo
 * @date    16 Oct 2013
 * @brief   Allows for commands: 
 *          - `[move]/[go] [to/down/into] <path>'   (where path is the id of that path)
 *          - `head [N/S/E/W]'                      (where path id is 'north' 'south' 'east' 'west')
 *          command.
 */
#ifndef __SwinAdventure__MoveCommand__
#define __SwinAdventure__MoveCommand__

// Includes and std namespace
#include <iostream>
#include <vector>
using namespace std;

// Include parent
#include "Command.h"

// Forward reference used classes
class Player;
class IHaveInventory;

class MoveCommand : public Command
{
public:
    // Constructor
    MoveCommand();
    
    // Override command abstract method
    virtual string execute(Player* player, vector<string> text);
    
    // Description for any invoked help command
    virtual string description();
};

#endif /* defined(__SwinAdventure__MoveCommand__) */
