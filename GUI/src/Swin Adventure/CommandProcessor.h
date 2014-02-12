/**
 * @class   Command Processor Class
 * @version 1.0
 * @file    CommandProcessor.h
 * @author  Alex Cummaudo
 * @date    07 Nov 2013
 * @brief   Class that processes input so that
 *          the input is processed by the relative
 *          command processor
 */


#ifndef __SwinAdventure__CommandProcessor__
#define __SwinAdventure__CommandProcessor__

#include <iostream>

// Include parent
#include "Command.h"

class CommandProcessor : public Command
{
public:
    
    // Constructor/Destructor
    CommandProcessor();
    ~CommandProcessor();
    
    // Override command abstract method
    virtual string execute(Player* player, vector<string> text);

    // Description for any invoked help command
    virtual string description();
    
private:
    
    // Private commands
    vector<Command*> _commands;
    
    // Help command
    string help();
    string help(string cmd_id);
    
};

#endif /* defined(__SwinAdventure__CommandProcessor__) */
