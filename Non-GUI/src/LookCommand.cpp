/**
 * @class   Look Command Class
 * @version 1.0
 * @file    LookCommand.cpp
 * @author  Alex Cummaudo
 * @date    08 Oct 2013
 * @brief   Implements Look Commands
 */

#include "LookCommand.h"

// Include used classes
#include "Player.h"
#include "IHaveInventory.h"
#include "Location.h"
#include "Inventory.h"
#include <sstream>

/**
 * @brief   Constructor to initialise parent (look is
 *          the identifier for this command)
 */
LookCommand::LookCommand()
            :Command(vector<string> ({"look", "examine"}))
{}

/**
 * @brief   Implements interface method of execute;
 *          checks the count of strings and executes
 *          appropriately (i.e. 0 vs. 3 vs. 5 strings?)
 */
string LookCommand::execute(Player* player, vector<string> text)
{
    int length = (int)text.size();
    
    string containerId = "";
    string itemId;
    if (length > 2) itemId = text[3-1];
    
    // Must be at least one word?
    if (!(length > 0))          { return "I don't know how to look like that!"; }
    // 'look' is not the first word?
    else if (text[1-1] != "look") { return "I don't understand that."; }
    // 'here' returns player's location
    else if (text[2-1] == "here" || text[2-1] == "around")
    {
        return player->get_location()->get_full_description();
    }
    // 'at' is not the second word?
    else if (text[2-1] != "at" && text[2-1] != "in")   { return "What should I look at?"; }
    // if 5 elements, then ensure 4th word is 'in'
    else if (length == 5 && text[4-1] != "in") { return "What should I look in?"; }
    // if 3 elements, then container id is inventory
    else if (length == 3) { containerId = "inventory"; }
    // if 5 elements, then container id is the 5'th word
    else if (length == 5) { containerId = text[5-1]; }
 
    // Dynamically cast whatever is retrurned from containerID
    // (e.g. it could be an inventory, an item etc.) and thus
    // dynamically cast whatever type this is at runtime using
    // dynamic_cast<ClassToCastTo> Blah...
    IHaveInventory *container =
        dynamic_cast<IHaveInventory *>(player->locate(containerId));
    
    if (container != NULL)
        return this->look_at_in(player, itemId, container);
    else
        return "Couldn't find the "+containerId;
}

/**
 * @brief   Executes the look in command
 */
string LookCommand::look_at_in(Player* player, string itemId, IHaveInventory *container)
{
    // Locate the item from container
    GameObj* item = container->locate(itemId);
    if (item != NULL)   { return item->get_full_desc(); }
    else                { return "Couldn't find the "+itemId; }
}


/**
 * @brief   Implements the interface method to provide
 *          description on how to use this command
 */
string LookCommand::description()
{
    stringstream response;
    response << "[look] " << "Usage: look here/around" << endl;
    response << "       " << "       look at/in inventory" << endl;
    response << "       " << "       look at/in <itemA> in <itemB>";
    return response.str();
}