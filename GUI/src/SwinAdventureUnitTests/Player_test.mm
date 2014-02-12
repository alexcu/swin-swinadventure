/**
 * @test    Player Object
 * @version 1.0
 * @file    Player_test.mm
 * @author  Alex Cummaudo
 * @date    20 Sept 2013
 * @brief   Implements unit testing of an Player
 */

#import <SenTestingKit/SenTestingKit.h>

#import "Player.h"
#import "Item.h"
#import "Inventory.h"

@interface Player_test : SenTestCase

@end

@implementation Player_test

- (void)test__are_you
{
    Player *plyr = new Player("Fred", "The most programmatically programmer that every programmed.");
    STAssertTrue(plyr->are_you_a("me"), @"Player does not respond to me identfier");
    STAssertTrue(plyr->are_you_a("inventory"), @"Player does not respond to inventory identfier");
}

- (void)test__locate_items
{
    Player *plyr = new Player("Fred", "The most programmatically programmer that every programmed.");
    
    // Create some random items
    vector<string> ids1;
    ids1.push_back("shovel");
    ids1.push_back("digger");
    ids1.push_back("spade");
    
    Item *shovel = new Item(ids1, "Small Shovel", "A simple shovel to dig with");
    
    vector<string> ids2;
    ids2.push_back("pen");
    ids2.push_back("biro");
    
    Item *pen = new Item(ids2, "Red Pen", "You write with this");
    
    vector<string> ids3;
    ids3.push_back("sword");
    ids3.push_back("dagger");
    
    Item *sword = new Item(ids3, "Great Sword", "Use sparingly");

    // Insert items into the inventory
    plyr->get_inventory()->put(shovel);
    plyr->get_inventory()->put(pen);
    plyr->get_inventory()->put(sword);
    
    // Test if player can locate its own items
    STAssertTrue(plyr->locate("shovel"), @"Could not locate existing item shovel within inventory!");
    STAssertTrue(plyr->locate("pen"), @"Could not locate existing item pen within inventory!");
    STAssertTrue(plyr->locate("sword"), @"Could not locate existing item sword within inventory!");
    // Test if player can locate itself
    STAssertTrue(plyr->locate("me"), @"Could not locate itself!");
    STAssertTrue(plyr->locate("inventory"), @"Could not locate itself!");
    // Test if player can locate non-existant item
    STAssertFalse(plyr->locate("chicken"), @"Player responded to non-existant id chicken!");
}

-(void)test__get_full_desc
{
    Player *plyr = new Player("Fred", "The most programmatically programmer that every programmed.");
    
    // Create some random items
    vector<string> ids1;
    ids1.push_back("shovel");
    ids1.push_back("digger");
    ids1.push_back("spade");
    
    Item *shovel = new Item(ids1, "Small Shovel", "A simple shovel to dig with");
    
    vector<string> ids2;
    ids2.push_back("pen");
    ids2.push_back("biro");
    
    Item *pen = new Item(ids2, "Red Pen", "You write with this");
    
    vector<string> ids3;
    ids3.push_back("sword");
    ids3.push_back("dagger");
    
    Item *sword = new Item(ids3, "Great Sword", "Use sparingly");
    
    // Insert items into the inventory
    plyr->get_inventory()->put(shovel);
    plyr->get_inventory()->put(pen);
    plyr->get_inventory()->put(sword);
    
    // Test Item List
    // Create comparison strings
    NSString *expected  = @"Small Shovel\nRed Pen\nGreat Sword\n";
    NSString *actual    = @(plyr->get_full_desc().c_str());
    
    STAssertEqualObjects(expected, actual, @"Bad comparison of string: expected %@, recieved %@", expected, actual);

}

@end
