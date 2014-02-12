/**
 * @class   Quit Command
 * @version 1.0
 * @file    QuitCommand.h
 * @author  Alex Cummaudo
 * @date    07 Nov 2013
 * @brief   Class that processes input so that
 *          the input is processed by the relative
 *          command processor
 */

#ifndef __SwinAdventure__QuitCommand__
#define __SwinAdventure__QuitCommand__

#include <iostream>

// Include parent file
#include "Command.h"

class QuitCommand : public Command
{
    
public:
    QuitCommand();
    
    // Override command abstract method
    virtual string execute(Player* player, vector<string> text);
    
    // Description for any invoked help command
    virtual string description();
};



#endif /* defined(__SwinAdventure__QuitCommand__) */
