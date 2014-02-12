/**
 * @test    MoveCommand Test
 * @version 1.0
 * @file    MoveCommand_test.mm
 * @author  Alex Cummaudo
 * @date    16 Oct 2013
 * @brief   Implements unit testing of an Location Commands
 */

#import <SenTestingKit/SenTestingKit.h>

#import "Player.h"
#import "MoveCommand.h"
#import "Location.h"
#import "Path.h"

@interface MoveCommand_test : SenTestCase
{
    Player*     _player;
    
    Location*   _city;
    Location*   _underground;
    
    Path*       _subway;
    Path*       _manhole;
    
    MoveCommand* _cmds;
    
    
}
@end

@implementation MoveCommand_test

- (void)setUp
{
    [super setUp];
    
    _player = new Player("Fred", "The lonely programmer");
    _cmds   = new MoveCommand();
    
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
    
    
}


- (void) test__move_directional
{
    // Create comparison strings
    NSString *expected = @"Fred went south and is now at underneath the city";
    NSString *actual   = @(_cmds->execute(_player, {"head","south"}).c_str());

    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);

    // Try for bad direction
    expected = @"I can't find anywhere to go there.";
    actual   = @(_cmds->execute(_player, {"head","north"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
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
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
    
    // Try for 'move' command
    expected = @"Fred went to the subway and is now at New York City";
    actual   = @(_cmds->execute(_player, {"move","into","subway"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
    
    // Try for bad direction
    expected = @"I can't find anywhere to go there.";
    actual   = @(_cmds->execute(_player, {"move","into","city"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
}

@end