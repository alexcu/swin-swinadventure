/**
 * @class   Game
 * @version 1.0
 * @author  Alex Cummaudo
 * @date    07 Nov 2013
 * @brief   Class that contains the `world' players
 *          will play in---it gets read from game.txt
 *          in the constructor
 */

#ifndef __SwinAdventure__Game__
#define __SwinAdventure__Game__

#include <iostream>

#include "IdObj.h"
#include "Player.h"
#include "Inventory.h"
#include "Item.h"
#include "GameObj.h"
#include "Bag.h"
#include "Location.h"
#include "Path.h"

// Include player class

class Game {

private:
    Player *_player;
    
public:
    // Constructor
    Game(string playerName, string playerDesc);
    
    Player *get_player() { return _player; }
};

#endif /* defined(__SwinAdventure__Game__) */
