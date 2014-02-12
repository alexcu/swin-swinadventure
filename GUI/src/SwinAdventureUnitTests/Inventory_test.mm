/**
 * @test    Inventory Object
 * @version 1.0
 * @file    Inventory_test.mm
 * @author  Alex Cummaudo
 * @date    20 Sept 2013
 * @brief   Implements unit testing of an Inventory
 */

#import <SenTestingKit/SenTestingKit.h>
#import "Inventory.h"
#import "Item.h"

@interface Inventory_test : SenTestCase

@end

@implementation Inventory_test

-(void) test__has_item
{
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
    
    // Create a new inventory, and insert items
    Inventory *inv = new Inventory();
    inv->put(shovel);
    inv->put(pen);
    
    // Check has item sword before sword added
    STAssertTrue(inv->has_item("shovel"), @"Did not respond to existant item shovel");
    STAssertTrue(inv->has_item("spade"), @"Did not respond to existant item spade (shovel)");
    STAssertTrue(inv->has_item("pen"), @"Did not respond to existant item pen");
    STAssertTrue(inv->has_item("biro"), @"Did not respond to existant item pen (biro)");
    STAssertFalse(inv->has_item("sword"), @"Responded to sword even though not inserted yet");
    
    inv->put(sword);
    STAssertTrue(inv->has_item("sword"), @"Did not respond to existant item sword.");
    
    // Test fetch
    inv->fetch("sword");
    STAssertTrue(inv->has_item("sword"), @"Did not responded to a still-existing sword.");

    // Test Take
    inv->take("pen");
    STAssertFalse(inv->has_item("pen"), @"Did not responded to a removed existing pen.");
}
-(void) test__list_items {

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

    // Create a new inventory, and insert items
    Inventory *inv = new Inventory();
    inv->put(shovel);
    inv->put(pen);
    inv->put(sword);

    // Test Item List
    // Create comparison strings
    NSString *expected  = @"Small Shovel\nRed Pen\nGreat Sword\n";
    NSString *actual    = @(inv->list_items().c_str());
    
    STAssertEqualObjects(expected, actual, @"Bad comparison of string: expected %@, recieved %@", expected, actual);
}

@end
