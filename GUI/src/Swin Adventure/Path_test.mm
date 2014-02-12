/**
 * @test    Path Test
 * @version 1.0
 * @file    Path_test.mm
 * @author  Alex Cummaudo
 * @date    12 Oct 2013
 * @brief   Implements unit testing of a path
 */


#import <SenTestingKit/SenTestingKit.h>

#import "Player.h"
#import "Location.h"
#import "Path.h"

@interface Path_test : SenTestCase
{
    Player*     _player;
    
    Location*   _city;
    Location*   _underground;
    
    Path*       _subway;
    Path*       _manhole;
}
@end

@implementation Path_test

- (void)setUp
{
    [super setUp];
    
    _player = new Player("Fred", "The lonely programmer");
    
    /**
     * Setup city and underground with path links
     */
    _city = new Location({"city"}, "New York City", "The Big Apple");
    _underground = new Location({"underground"}, "Underneath the city", "Smelly sewers");

    // Allow manhole to be **unidirectional**
    _manhole = new Path({"manhole"}, "manhole", "A small manhole", _underground, false);

    // Allow subway to be **bidirectional**
    _subway  = new Path({"subway"}, "subway", "A subway back up", _city, true);
    
    _city->add_path(_manhole);
    _underground->add_path(_subway);
    
    // Hence the movement of paths are:
    
    //  [      ] --> (manhole) --> [             ]
    //  [ City ]                   [ Underground ]
    //  [      ] <-> (subway ) <-> [             ]
}

- (void) test__move_player
{
    // Initialise player location at city
    _player->set_location(_city);
    STAssertTrue(_player->locate("city"), @"Couldn't locate current location (city)");
    
    /**
     * Trying unidirectional manhole
     */
    // Move down manhole
    _manhole->move(_player);
    STAssertTrue(_player->locate("underground"), @"Couldn't move down the manhole to underground");
    
    // Try moving back up via the manhole
    _manhole->move(_player);
    STAssertFalse(_player->locate("city"), @"Somehow made it back up the manhole to the city");

    /**
     * Trying bidirectional subway
     */
    // Move down the subway back up to the city
    _subway->move(_player);
    STAssertTrue(_player->locate("city"), @"Couldn't move back up city via manhole");
    
    // Move back down the subway back to underground (unidirectional!)
    _subway->move(_player);
    STAssertTrue(_player->locate("underground"), @"Couldn't move back down to underground via subway");
    
    // Move down the subway back up to the city
    _subway->move(_player);
    STAssertTrue(_player->locate("city"), @"Couldn't moved back up from underground to city via subway");
    
}

@end
