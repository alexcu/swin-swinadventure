/**
 * @class   Quit Command
 * @version 1.0
 * @file    QuitCommand.cpp
 * @author  Alex Cummaudo
 * @date    07 Nov 2013
 * @brief   Class that processes input so that
 *          the input is processed by the relative
 *          command processor
 */

#include "QuitCommand.h"

// Import player
#include "Player.h"

/**
 * @brief   Constructor to initialise parent (quit/exit is
 *          the identifier for this command)
 */
QuitCommand::QuitCommand()
:Command(vector<string> ({"quit", "exit"}))
{}

/**
 * @brief   Implements interface method of execute;
 *          checks the first word in the string and
 *          processes as needed
 */
string QuitCommand::execute(Player *player, vector<string> text)
{
    if (text[1-1] == "quit" || text[1-1] == "exit")
    {
        return "Quitting";
    }
    else return "I don't understand that";
}

/**
 * @brief   Implements the interface method to provide
 *          description on how to use this command
 */
string QuitCommand::description()
{
    return "[quit] Usage: quits the program";
}