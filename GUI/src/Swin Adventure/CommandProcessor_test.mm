/**
 * @test    Command Processor Test
 * @version 1.0
 * @file    CommandProcessor_test.mm
 * @author  Alex Cummaudo
 * @date    7 Nov 2013
 * @brief   Implements unit testing of all commands
 */

#import <SenTestingKit/SenTestingKit.h>

#import "Player.h"
#import "CommandProcessor.h"
#import "Location.h"
#import "Path.h"
#import "Bag.h"
#import "Inventory.h"

@interface CommandProcessor_test : SenTestCase
{
    Player*     _player;
    Inventory   *_inv;
    
    Location*   _city;
    Location*   _underground;
    
    Path*       _subway;
    Path*       _manhole;
    
    CommandProcessor* _cmds;

    
}
@end

@implementation CommandProcessor_test

- (void)setUp
{
    [super setUp];
    
    _player = new Player("Fred", "The lonely programmer");
    _cmds   = new CommandProcessor();
    
    /**
     * Setup city and underground with path links
     */
    _city = new Location({"city"}, "New York City", "The Big Apple");
    _underground = new Location({"underground"}, "underneath the city", "Smelly sewers");
    
    // Allow manhole to be **unidirectional**
    _manhole = new Path({"manhole", "south"}, "manhole", "A small manhole", _underground, false);
    
    // Allow subway to be **bidirectional**
    _subway  = new Path({"subway"}, "subway", "A subway back up", _underground, true);
    
    _city->add_path(_manhole);
    _city->add_path(_subway);
    
    _player->set_location(_city);
    
    // Hence the movement of paths are:
    
    //  [      ] --> (manhole) --> [             ]
    //  [ City ]                   [ Underground ]
    //  [      ] <-> (subway ) <-> [             ]
    
    _inv    = _player->get_inventory();
    
    // Create some random items
    vector<string> ids1;
    ids1.push_back("pen");
    ids1.push_back("biro");
    Item *pen = new Item(ids1, "pen", "A standard blue pen");
    
    vector<string> ids2;
    ids2.push_back("shovel");
    ids2.push_back("digger");
    ids2.push_back("spade");
    Item *shovel = new Item(ids2, "shovel", "A worn out shovel");
    
    vector<string> ids3;
    ids3.push_back("sword");
    ids3.push_back("dagger");
    Item *sword = new Item(ids3, "sword", "A very sharp sword");
    
    _inv->put(pen);
    _inv->put(shovel);
    _inv->put(sword);
    
    
    // Create a second bag with some items
    vector<string> ids;
    ids.push_back("wallet");
    ids.push_back("purse");
    ids.push_back("moneybag");
    
    Bag *wallet = new Bag(ids, "wallet", "A leather wallet");
    
    // Create some random items
    vector<string> ids4;
    ids4.push_back("myki");
    ids4.push_back("travel card");
    Item *myki = new Item(ids4, "myki", "A concession myki card");
    
    vector<string> ids5;
    ids5.push_back("cash");
    ids5.push_back("money");
    ids5.push_back("notes");
    Item *cash = new Item(ids5, "cash", "A twenty dollar note");
    
    vector<string> ids6;
    ids6.push_back("id");
    ids6.push_back("drivers licence");
    Item *idcard = new Item(ids6, "id", "A standard drivers license");
    
    // Add the items to the wallet
    Inventory *invWallet = wallet->get_inventory();
    invWallet->put(myki);
    invWallet->put(cash);
    invWallet->put(idcard);
    
    // Add the wallet to the inv
    _inv->put(wallet);
}

// TESTING MOVE COMMAND INSIDE COMMAND PROCESSOR

- (void) test__move_directional
{
    // Create comparison strings
    NSString *expected = @"Fred went south and is now at underneath the city";
    NSString *actual   = @(_cmds->execute(_player, {"head","south"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
    
    // Try for bad direction
    expected = @"I can't find anywhere to go there.";
    actual   = @(_cmds->execute(_player, {"head","north"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}

- (void) test__move_place
{
    // Try for 'go' command
    NSString *expected = @"Fred went to the subway and is now at underneath the city";
    NSString *actual   = @(_cmds->execute(_player, {"go","down","subway"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
    
    // Try for bad direction
    expected = @"I can't find anywhere to go there.";
    actual   = @(_cmds->execute(_player, {"go","into","nowhere"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
    
    // Try for 'move' command
    expected = @"Fred went to the subway and is now at New York City";
    actual   = @(_cmds->execute(_player, {"move","into","subway"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
    
    // Try for bad direction
    expected = @"I can't find anywhere to go there.";
    actual   = @(_cmds->execute(_player, {"move","into","city"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}

// TESTING LOOK COMMAND INSIDE COMMAND PROCESSOR

- (void)test__look_at_me
{
    // Create comparison strings
    NSString *expected = @"pen\nshovel\nsword\nwallet\n";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","me"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}

- (void)test__look_at_sword
{
    // Create comparison strings
    NSString *expected = @"A very sharp sword";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","sword"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}

- (void)test__look_at_sword_after_take
{
    // Take the word
    _inv->take("sword");
    
    // Now repeat
    NSString *expected = @"Couldn't find the sword";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","sword"}).c_str());
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}


- (void)test__look_at_sword_in_inv
{
    // Create comparison strings
    NSString *expected = @"A very sharp sword";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","sword","in","inventory"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}

- (void)test__look_at_cash_in_bag
{
    // Create comparison strings
    NSString *expected = @"A twenty dollar note";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","cash","in","wallet"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}

- (void)test__look_at_cash_no_bag
{
    // Take the word
    Item* wallet = _inv->take("wallet");
    
    // Create comparison strings
    NSString *expected = @"Couldn't find the wallet";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","cash","in","wallet"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
    
    // Put the wallet back for next time
    _inv->put(wallet);
}


- (void)test__look_at_no_item_in_bag
{
    // Create comparison strings
    NSString *expected = @"Couldn't find the banana";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","banana","in","wallet"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}


- (void)test__invalid_look
{
    // Create comparison strings
    NSString *expected = @"What should I look at?";
    NSString *actual   = @(_cmds->execute(_player, {"look","banana"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
    
    expected = @"What should I look in?";
    actual   = @(_cmds->execute(_player, {"look","at","a","at","b"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
    
}

// TESTING HELP
- (void)test__help
{
    // Create comparison strings
    NSString *expected =
@"[look] Usage: look here/around\n\
              look at/in inventory\n\
              look at/in <itemA> in <itemB>\n\
[move] Usage: move/go into/to/down <path>\n\
[head] Usage: head <north/south/east/west>\n\
[quit] Usage: quits the program\n\
[take] Usage: take <item>\n\
              take <item> from inventory\n\
              take <item> from <bag>\n\
[put ] Usage: put <item> in <bag>\n\
[drop] Usage: drop <item>\n\
[help] Usage: shows help for commands that can be entered\n";
    NSString *actual   = @(_cmds->execute(_player, {"help"}).c_str());
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}

// TESTING CONTEXT-SENSITIVE HELP (for put ?)
-(void)test__help_context_command_exists
{
    // Create comparison strings
    NSString *expected =  @"[help] Usage: shows help for commands that can be entered";
    NSString *actual   = @(_cmds->execute(_player, {"help", "?"}).c_str());
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}
-(void)test__help_context_command_non_exists
{
    // Create comparison strings
    NSString *expected = @"Can't provide help for a command that doesn't exist!";
    NSString *actual   = @(_cmds->execute(_player, {"banana", "?"}).c_str());
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}

// TEST QUIT COMMAND INSIDE COMMAND PROCESSOR
-(void)test__quit
{
    // Create comparison strings
    NSString *expected = @"Quitting";
    NSString *actual   = @(_cmds->execute(_player, {"quit"}).c_str());
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}
// TESTING INVALID COMMAND INSIDE COMMAND PROCESSOR

- (void)test__invalid_command
{
    // Create comparison strings
    NSString *expected = @"I don't understand that";
    NSString *actual   = @(_cmds->execute(_player, {"hello","there"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %@, recieved %@", expected, actual);
}


@end