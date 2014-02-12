/**
 * @class   Command Class
 * @version 1.0
 * @author  Alex Cummaudo
 * @date    08 Oct 2013
 * @brief   Abstract class that allows for
 *          parsing through commands
 */

#ifndef __SwinAdventure__Command__
#define __SwinAdventure__Command__

// Includes and std namespace
#include <iostream>
#include <vector>
using namespace std;

// Include parent
#include "IdObj.h"

// Forward reference used classes
class Player;

class Command : public IdObj  {
public:
    // Constructor
    Command(vector<string>ids);
    
    // Public methods (abstract)
    virtual string execute(Player *player, vector<string> text) = 0;
    
    // Description for any invoked help command
    virtual string description() = 0;
};

#endif /* defined(__SwinAdventure__Command__) */
