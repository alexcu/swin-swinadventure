/**
 * @class   Game
 * @version 1.0
 * @author  Alex Cummaudo
 * @date    07 Nov 2013
 * @brief   Class that contains the `world' players
 *          will play in---it gets read from game.txt
 *          in the constructor
 */

#include "Game.h"

/**
 * @brief   Constructor reads in the XML file games.xml
 *          and generates the enviornment
 */
Game::Game(string playerName, string playerDesc)
{
    _player = new Player(playerName, playerDesc);
    #include "../game.txt"
}