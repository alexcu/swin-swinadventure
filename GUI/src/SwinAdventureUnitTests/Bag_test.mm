/**
 * @test    Item
 * @version 1.0
 * @file    Item_test.mm
 * @author  Alex Cummaudo
 * @date    20 Sept 2013
 * @brief   Implements unit testing of a Bag
 */

#import <SenTestingKit/SenTestingKit.h>

#import "Bag.h"
#import "Inventory.h"

@interface Bag_test : SenTestCase {
    Bag*    _mainBag;
}

@end

@implementation Bag_test

- (void) setUp
{
    // Create the main backpack
    vector<string> ids;
    ids.push_back("backpack");
    ids.push_back("satchel");
    ids.push_back("manbag");
    
    _mainBag = new Bag(ids, "backpack", "A grey, worn out backpack");
    
    // Create some random items
    vector<string> ids1;
    ids1.push_back("pen");
    ids1.push_back("biro");
    Item *pen = new Item(ids1, "A pen", "A standard blue pen");
    
    vector<string> ids2;
    ids2.push_back("shovel");
    ids2.push_back("digger");
    ids2.push_back("spade");
    Item *shovel = new Item(ids2, "A shovel", "A worn out shovel");
    
    vector<string> ids3;
    ids3.push_back("sword");
    ids3.push_back("dagger");
    Item *sword = new Item(ids3, "A sword", "A very sharp sword");
    
    // Add the items to the bag
    Inventory *inv = _mainBag->get_inventory();
    inv->put(shovel);
    inv->put(sword);
    inv->put(pen);
}

/**
 * @note    I will use my own Obj-C syntax test__method_name
 *          since it makes it easier for me to to the right
 *          method (with different, C++ syntax)
 */

- (void) test__locating_items
{
    // Locate my own items
    STAssertTrue(_mainBag->locate("shovel"), @"Bag did not respond to existing item shovel");
    STAssertTrue(_mainBag->locate("biro"),   @"Bag did not respond to existing item pen");
    STAssertTrue(_mainBag->locate("dagger"), @"Bag did not respond to existing item sword");
    
    // Locate myself
    STAssertTrue(_mainBag->locate("satchel"), @"Bag did not respond to locating itself");
    
    // Locate non-existant item
    STAssertFalse(_mainBag->locate("banana"),  @"Bag responded to non-existant banana");
}

- (void) test__get_full_desc
{
    // Create comparison strings
    NSString *actual   = @(_mainBag->get_full_desc().c_str());
    NSString *expected = @"In the backpack you see:\nA shovel\nA sword\nA pen\n\n";
    STAssertEqualObjects(expected, actual, @"Description was incorrect: expected %@, recieved %@", expected, actual);
}

- (void) test__bag_in_bag
{
    // Create a second bag with some items
    vector<string> ids;
    ids.push_back("wallet");
    ids.push_back("purse");
    ids.push_back("moneybag");
    
    Bag *wallet = new Bag(ids, "wallet", "A leather wallet");
    
    // Create some random items
    vector<string> ids1;
    ids1.push_back("myki");
    ids1.push_back("travel card");
    Item *myki = new Item(ids1, "A myki card", "A concession myki card");
    
    vector<string> ids2;
    ids2.push_back("cash");
    ids2.push_back("money");
    ids2.push_back("notes");
    Item *cash = new Item(ids2, "Some cash", "A twenty dollar note");
    
    vector<string> ids3;
    ids3.push_back("id");
    ids3.push_back("drivers licence");
    Item *idcard = new Item(ids3, "An id card", "A standard drivers license");
    
    // Add the items to the wallet
    Inventory *invWallet = wallet->get_inventory();
    invWallet->put(myki);
    invWallet->put(cash);
    invWallet->put(idcard);
    
    // Add the wallet to the bag
    Inventory *invBag = _mainBag->get_inventory();
    invBag->put(wallet);
    
    // Check the description of both
    NSString *actual   = @(wallet->get_full_desc().c_str());
    NSString *expected = @"In the wallet you see:\nA myki card\nSome cash\nAn id card\n\n";
    STAssertEqualObjects(expected, actual, @"Description was incorrect: expected %@, recieved %@", expected, actual);
    
    // Create comparison strings
    actual   = @(_mainBag->get_full_desc().c_str());
    expected = @"In the backpack you see:\nA shovel\nA sword\nA pen\nwallet\n\n";
    STAssertEqualObjects(expected, actual, @"Description was incorrect: expected %@, recieved %@", expected, actual);
}

@end
