/**
 * @class   I Have Inventory
 * @version 1.0
 * @author  Alex Cummaudo
 * @date    08 Oct 2013
 * @brief   Interface for anything that has its own
 *          inventory
 */

#ifndef __SwinAdventure__IHaveInventory__
#define __SwinAdventure__IHaveInventory__

// Includes and std namespace
#include <iostream>
#include <vector>
using namespace std;

// Forward reference used classes
class GameObj;
class Inventory;
class IHaveInventory
{
public:
    // Declare interface methods
    virtual GameObj*    locate(string id)   = 0;
    virtual Inventory*  get_inventory()     = 0;
    virtual string      get_name()          = 0;
};

#endif /* defined(__SwinAdventure__IHaveInventory__) */
