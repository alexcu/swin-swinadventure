/**
 * @class   Put Command Class
 * @version 1.0
 * @file    PutCommand.cpp
 * @author  Alex Cummaudo
 * @date    08 Oct 2013
 * @brief   Implements Put Commands
 */


#include "PutCommand.h"

// Include items
#include "Item.h"
#include "IHaveInventory.h"
#include "Player.h"
#include "Inventory.h"
#include "Location.h"
#include <sstream>

/**
 * @brief   Constructor to initialise parent (head/move/go are
 *          the identifiers for this command)
 */
PutCommand::PutCommand()
:Command(vector<string> ({"put", "drop"}))
{}


/**
 * @brief   Implements interface method of execute;
 *          checks the count of strings and executes
 *          appropriately
 *          i.e. put <item> in <bag>
 *               drop <item> (to env.)
 */
string PutCommand::execute(Player *player, vector<string> text)
{
    int length = (int)text.size();
    IHaveInventory *container = nullptr;
    string itemId = "";
    
    if (length > 1)
    {
        // Put into from env.
        if (length == 2 && text[1-1] == "drop")
        {
            // Item to drop is the 2nd word
            itemId = text[2-1];
            // Container is the player's current env's
            container = dynamic_cast<IHaveInventory *>(player->get_location());
        }
        // Else put in a bag
        if (length >= 4 && text[1-1] == "put" && text[3-1] == "in")
        {
            // Item to get is the 2nd word
            itemId = text[2-1];
            // Container is the 4th word
            container = dynamic_cast<IHaveInventory *>(player->locate(text[4-1]));
        }
    }
    
    // Given the container is existant
    if (container != NULL)
        return this->put_something_in(player, itemId, container);
    else
        return "Couldn't find the "+itemId;
    
}

/**
 * @brief   Executes the look in command
 */
string PutCommand::put_something_in(Player* player, string itemId, IHaveInventory *container)
{
    // Take the item from the players inventory
    Item *itemToPut = player->get_inventory()->take(itemId);
    
    // Found it (not NULL)... so drop it in the container and notify that you did.
    if (itemToPut != NULL)
    {
        container->get_inventory()->put(itemToPut);
        return "I placed the "+ itemId +" in "+container->get_name();
    }
    // Else explicitly return that couldn't find it
    else
    {
        return "I don't have that item!";
    }
}


/**
 * @brief   Implements the interface method to provide
 *          description on how to use this command
 */
string PutCommand::description()
{
    stringstream response;
    response << "[put ] " << "Usage: put <item> in <bag>" << endl;
    response << "[drop] " << "Usage: drop <item>";
    return response.str();
}