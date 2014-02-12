/**
 * @class   Take Command Class
 * @version 1.0
 * @file    TakeCommand.cpp
 * @author  Alex Cummaudo
 * @date    08 Nov 2013
 * @brief   Implements Take Commands
 */


#include "TakeCommand.h"

// Include items
#include "Item.h"
#include "IHaveInventory.h"
#include "Player.h"
#include "Inventory.h"
#include "Location.h"
#include "Path.h"
#include <sstream>

/**
 * @brief   Constructor to initialise parent (head/move/go are
 *          the identifiers for this command)
 */
TakeCommand::TakeCommand()
:Command(vector<string> ({"take"}))
{}

/**
 * @brief   Implements interface method of execute;
 *          checks the count of strings and executes
 *          appropriately
 *          i.e. take <item> takes from env.
 *               take <item> from <bag> takes from bag
 */
string TakeCommand::execute(Player *player, vector<string> text)
{
    int length = (int)text.size();
    string containerId = "";
    string itemId = "item";
    
    if (length > 1)
    {
        // Take from env.
        if (length == 2 && text[1-1] == "take")
        {
            // Item to get is the 2nd word
            itemId = text[2-1];
            // Container id is the player's current env's first id
            containerId = player->get_location()->first_id();
        }
        // Else take from a bag
        if (length >= 4 && text[1-1] == "take" && text[3-1] == "from")
        {
            // Item to get is the 2nd word
            itemId = text[2-1];
            // Item to get from is the 4th word
            containerId = text[4-1];
        }
    }
    
    // Dynamically cast whatever is retrurned from containerID
    // (e.g. it could be an inventory, an item etc.) and thus
    // dynamically cast whatever type this is at runtime using
    // dynamic_cast<ClassToCastTo> Blah...
    IHaveInventory *container =
    dynamic_cast<IHaveInventory *>(player->locate(containerId));
    
    if (container != NULL)
        return this->take_something_in(player, itemId, container);
    else
        return "I couldn't find the "+itemId;
    
}

/**
 * @brief   Executes the look in command
 */
string TakeCommand::take_something_in(Player* player, string itemId, IHaveInventory *container)
{
    // Locate the item from container
    GameObj *item = container->locate(itemId);
    
    // Dynamically cast the GameObj found to check if we're about to take an entire path!!
    Path *pathTest =
        dynamic_cast<Path *>(container->locate(itemId));
    
    // Found it... so take it and notify that you did (given that this isn't a path!)
    if (item != NULL && pathTest == NULL)
    {
        Item *itemToTake = container->get_inventory()->take(itemId);
        player->get_inventory()->put(itemToTake);
        return "Took the "+itemId;
    }
    // Else explicitly return that couldn't find it
    else
    {
        return "I couldn't find/take the "+itemId+" inside the "+container->get_name();
    }
}

/**
 * @brief   Implements the interface method to provide
 *          description on how to use this command
 */
string TakeCommand::description()
{
    stringstream response;
    response << "[take] " << "Usage: take <item>" << endl;
    response << "       " << "       take <item> from inventory" << endl;
    response << "       " << "       take <item> from <bag>";
    return response.str();
}