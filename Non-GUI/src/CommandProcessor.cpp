/**
 * @class   Command Processor Class
 * @version 1.0
 * @file    command.h
 * @author  Alex Cummaudo
 * @date    07 Nov 2013
 * @brief   Class that processes input so that
 *          the input is processed by the relative
 *          command processor
 */

// Include my header
#include "CommandProcessor.h"

// Include the headers of my commands
#include "LookCommand.h"
#include "MoveCommand.h"
#include "QuitCommand.h"
#include "TakeCommand.h"
#include "PutCommand.h"
#include <sstream>

/**
 * @brief   Constructor to initialise parent (no ids for the command pro)
 *          and sets up all command objects
 */
CommandProcessor::CommandProcessor()
:Command(vector<string> ())
{
    LookCommand *cmdLook = new LookCommand();
    MoveCommand *cmdMove = new MoveCommand();
    QuitCommand *cmdQuit = new QuitCommand();
    TakeCommand *cmdTake = new TakeCommand();
    PutCommand  *cmdPut  = new PutCommand();
    
    _commands.push_back(cmdLook);
    _commands.push_back(cmdMove);
    _commands.push_back(cmdQuit);
    _commands.push_back(cmdTake);
    _commands.push_back(cmdPut);
    _commands.push_back(this);
}

CommandProcessor::~CommandProcessor()
{
    _commands.erase(_commands.begin(), _commands.end());
}

/**
 * @brief   Implements interface method of execute;
 *          checks the first word in the string and
 *          then passes it onto which command should
 *          execute it
 *          i.e. Move/Head/Go = Move Command
 *               Look         = Look Command
 */
string CommandProcessor::execute(Player *player, vector<string> text)
{
    // The command id is the first word
    string cmd_id = text[1-1];
 
    if (cmd_id == "help" || cmd_id == "?") return this->help();
    
    // Second word is a ?; print help for that command
    if (text.size() > 1) if (text[2-1] == "?") return this->help(cmd_id);
    
    // Get iterator index of this cmd_id
    auto i =  find_if(_commands.begin(), _commands.end(),
                      [&cmd_id](Command *cmd) { return cmd->are_you_a(cmd_id); });
    
    // If I have a command with that cmd_id, execute (and return) on the cmd_id given
    if (i != _commands.end()) { return _commands[i - _commands.begin()]->execute(player, text); }
    
    // Else say command not found
    else { return "I don't understand that"; }
    
}

/**
 * @brief   Implements the interface method to provide
 *          description on how to use this command
 */
string CommandProcessor::description()
{
    return "[help] Usage: shows this list";
}

/**
 * @brief   Provides the help description for all my
 *          commands
 */
string CommandProcessor::help()
{
    stringstream response;
    
    for_each(_commands.begin(), _commands.end(),
             [&response](Command* cmd) { response << cmd->description() << endl; });
    
    return response.str();
}

/**
 * @brief   Provides the help description for the
 *          command with the given cmd_id
 */
string CommandProcessor::help(string cmd_id)
{
    auto i = find_if(_commands.begin(), _commands.end(),
                     [&cmd_id](Command *cmd){ return cmd->are_you_a(cmd_id); });
    if (i != _commands.end()) { return _commands[i - _commands.begin()]->description(); }
    else                      { return "Can't provide help for a command that doesn't exist!"; }
}


