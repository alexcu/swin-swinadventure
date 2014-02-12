/**
 * @name    SwinAdventure
 * @version 1.0
 * @author  Alex Cummaudo
 * @date    19 Sept 2013
 * @brief   Main file for GUI SwinAdventure
 */

#import <Cocoa/Cocoa.h>

class Game;
class CommandProcessor;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    // Create ivars
    CommandProcessor    *_cmdProcessor;
    Game                *_game;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *prompt;
@property (unsafe_unretained) IBOutlet NSTextView *console;
@property (weak) IBOutlet NSMenuItem *helpButton;


@end
