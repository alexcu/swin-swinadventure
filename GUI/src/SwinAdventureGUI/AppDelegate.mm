/**
 * @name    SwinAdventure
 * @version 1.0
 * @author  Alex Cummaudo
 * @date    19 Sept 2013
 * @brief   Main file for GUI SwinAdventure
 */

#import "AppDelegate.h"

#import <iostream>
#import "Game.h"
#include "CommandProcessor.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Construct processor
    _cmdProcessor = new CommandProcessor();
    // Ensure game is NULL since not initialsied here (initialised when name entered)
    _game = NULL;
    // Disallow help until name entered
    [_helpButton setEnabled:NO];
    // Prompt for name input
    [_console setString:@"Welcome to SwinAdventure! \nEnter your name"];
}

- (IBAction)commandSent:(id)sender
{
    string input = [[_prompt stringValue] UTF8String];

    if (_game == NULL)
    {
        // Initialise everything now since name is not set!
        _game = new Game(input, "Student 1744070");
        
        // Allow help henceforth
        [_helpButton setEnabled:YES];
        
        // Append string to console
        [_console setString:@"Now what?"];
    }
    else
    {
        // Command processing
        vector<string> subStrings;
        string word = "";
        
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
            NSString *response =
            [NSString stringWithFormat:@"%s", _cmdProcessor->execute(_game->get_player(), subStrings).c_str()];
            
            // Append string to console
            [_console setString:response];
            
            // Check if quitting
            if ([response  isEqual: @"Quitting"]) { [NSApp terminate:self]; }
            
            // Revert input to blank after execution
            input.clear();
            // Clear string for next time
            subStrings.clear();
        }
    }
    
    // Clear prompt
    [_prompt setStringValue:@""];
}
- (IBAction)helpButtonPressed:(id)sender
{
    // Get the input
    NSString *response =
    [NSString stringWithFormat:@"%s", _cmdProcessor->execute(_game->get_player(), {"?"}).c_str()];
    
    // Append string to console
    [_console setString:response];
    
    // Check if quitting
    if ([response  isEqual: @"Quitting"]) { [NSApp terminate:self]; }
}

@end
