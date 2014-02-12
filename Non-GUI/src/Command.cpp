/**
 * @class   Command Class
 * @version 1.0
 * @author  Alex Cummaudo
 * @date    08 Oct 2013
 * @brief   Implements Command
 */

#include "Command.h"

/**
 * @brief   Constructor for the Command
 *          implements parent
 */
Command::Command(vector<string>ids)
        :IdObj(vector<string> (ids))
{}
