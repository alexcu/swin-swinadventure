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
    string itemId = "item";
    
    IHaveInventory *container = nullptr;
    
    if (length > 1)
    {
        // Take from env.
        if (length == 2 && text[1-1] == "take")
        {
            // Item to get is the 2nd word
            itemId = text[2-1];
            // Container is the player's current env's
            container = dynamic_cast<IHaveInventory *>(player->get_location());
        }
        // Else take from a bag
        if (length >= 4 && text[1-1] == "take" && text[3-1] == "from")
        {
            // Item to get is the 2nd word
            itemId = text[2-1];
            // Container is the 4'th word (i.e. take X from <CONTAINER>)
            container = dynamic_cast<IHaveInventory *>(player->locate(text[4-1]));
        }
    }
    
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
    // Dynamically cast the GameObj found to check if we're about to take an entire path!!
    Path *pathTest =
        dynamic_cast<Path *>(container->locate(itemId));
    
    // I'm not about to take a path!
    if (pathTest == NULL)
    {
        // Take the item out of its inventory into limbo (on the stack here!)
        Item *itemToTake = container->get_inventory()->take(itemId);
        
        // Given that we've actually found an item!
        if (itemToTake != NULL)
        {
            // Put the item into the players inventory (back onto the heap!)
            player->get_inventory()->put(itemToTake);
            return "Took the "+itemId;
        }
        // Else return that I can't find it
        else
        {
            return "I couldn't find the "+itemId+" inside the "+container->get_name();
        }
    }
    // Else, return that I'm not going to take a path
    else
    {
       return "I'm not strong enough to the "+itemId+"!";
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