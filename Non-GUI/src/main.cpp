/**
 * @name    SwinAdventure
 * @version 1.0
 * @file    main.cpp
 * @author  Alex Cummaudo
 * @date    19 Sept 2013
 * @brief   Main file for SwinAdventure
 */

#include <iostream>
#include <algorithm>
#include "Bag.cpp"
#include "Bag.h"
#include "Command.cpp"
#include "Command.h"
#include "CommandProcessor.cpp"
#include "CommandProcessor.h"
#include "Game.cpp"
#include "Game.h"
#include "GameObj.cpp"
#include "GameObj.h"
#include "IdObj.cpp"
#include "IdObj.h"
#include "IHaveInventory.h"
#include "Inventory.cpp"
#include "Inventory.h"
#include "Item.cpp"
#include "Item.h"
#include "Location.cpp"
#include "Location.h"
#include "LookCommand.cpp"
#include "LookCommand.h"
#include "MoveCommand.cpp"
#include "MoveCommand.h"
#include "Path.cpp"
#include "Path.h"
#include "Player.cpp"
#include "Player.h"
#include "PutCommand.cpp"
#include "PutCommand.h"
#include "QuitCommand.cpp"
#include "QuitCommand.h"
#include "TakeCommand.cpp"
#include "TakeCommand.h"

int main(int argc, const char * argv[]) {
    
    cout << "SwinAdventure" << endl << "===============" << endl;
    
    /**
     * Initiate the player
     */
    string playerName;
    cout << "What is your name? ";
    getline(cin, playerName);
    
    Game *_game = new Game(playerName, "Student 1744070");
    
    /**
     * Setup commands
     */
    string input;
    vector<string> subStrings;
    string word = "";
    
    CommandProcessor *cmd = new CommandProcessor();
    while (true) {
        
        // Print prompt text
        cout << endl << "Now what? ";
        
        // Read whole string from user
        getline(cin, input);
        
        // Add a space at the end of the string
        // (therefore last word is counted)
        input += " ";
        // Define the start of a new word
        int wordStart = 0;
        
        // For every charater in the input string
        for (int i = 0; i <= input.length(); i++)
        {
            // Where there is a space
            if (input[i] == ' ')
            {
                // Create a word using every char up to the space
                for (int j = wordStart;  j < i; j++) word += input[j];
                // Add that new word to the substring vector
                subStrings.push_back(word);
                // Reset the word for next time
                word = "";
                // Start at new word for wordStart counter
                wordStart = i + 1;
            }
        }
        
        if (input[0] != ' ')
        {
            // Get the input
            string response = cmd->execute(_game->get_player(), subStrings);
            cout << response;
            
            // Quit check
            if (response == "Quitting") break;
            
            // Revert input to blank after execution
            input.clear();
            // Clear string for next time
            subStrings.clear();
        }
        
    }
    return 0;
}

