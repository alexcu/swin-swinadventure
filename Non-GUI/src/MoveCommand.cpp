/**
 * @class   Move Command Class
 * @version 1.0
 * @file    MoveCommand.cpp
 * @author  Alex Cummaudo
 * @date    16 Oct 2013
 * @brief   Implements Look Commands
 */

#include "MoveCommand.h"

// Include used classes
#include "Player.h"
#include "Path.h"
#include "Location.h"
#include <sstream>

/**
 * @brief   Constructor to initialise parent (head/move/go are
 *          the identifiers for this command)
 */
MoveCommand::MoveCommand()
:Command(vector<string> ({"head", "move", "go"}))
{}

/**
 * @brief   Implements interface method of execute;
 *          checks the count of strings and executes
 *          appropriately (i.e. 0 vs. 3 vs. 5 strings?)
 */
string MoveCommand::execute(Player* player, vector<string> text)
{
    int length = (int)text.size();
    string pathId;
    
    // Must be at least one word?
    if (!(length > 1))
    { return "I don't know how to go there!"; }
    
    // 'move/go/head' is not the first word?
    else if (text[1-1] != "move" && text[1-1] != "head" && text[1-1] != "go")
    { return "I don't understand that."; }

    // Move or go is the first word
    else if (text[1-1] == "move" || text[1-1] == "go")
    {
        // 'to/down/into' is not the second word for move and go
        if (!(text[2-1] == "into" || text[2-1] == "to" || text[2-1] == "down"))
        { return "Down, into or to where?"; }
        // Otherwise, path id is 3nd word
        else
        { pathId = text[3-1]; }
    }

    
    // Head is the first word
    else if (text[1-1] == "head")
    {
        // 'north/south/east/west' is not the second word for
        if (!(text[2-1] == "north" || text[2-1] == "south" || text[2-1] == "east" || text[2-1] == "west"))
        { return "I'll need a direction for that."; }
        // Otherwise, direction is 2nd word
        else
        { pathId = text[2-1]; }
    }
    
    
    // Use a dynamic cast like the look command
    Path *path =
        dynamic_cast<Path *>(player->locate(pathId));
    
    // Player locates a location with that id (i.e. !null)
    if (path != NULL)
    {
        // Cast the game obj as a path
        path->move(player);
        return  player->get_name()                                                      +
                " went "                                                                +
                // Went to the <path> vs. Went north
                ((text[1-1] == "head") ? text[2-1] : "to the " + path->get_name())      +
                " and is now at "                                                       +
                player->get_location()->get_name();
    }
    else
    { return "I can't find anywhere to go there."; }

}

/**
 * @brief   Implements the interface method to provide
 *          description on how to use this command
 */
string MoveCommand::description()
{
    stringstream response;
    response << "[move] " << "Usage: move/go into/to/down <path>" << endl;
    response << "[head] " << "Usage: head <north/south/east/west>";
    return response.str();
}
