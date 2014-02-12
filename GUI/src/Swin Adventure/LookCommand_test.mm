/**
 * @test    LookCommand Test
 * @version 1.0
 * @file    LookCommand_test.mm
 * @author  Alex Cummaudo
 * @date    07 Oct 2013
 * @brief   Implements unit testing of an Location Commands
 */

#import <SenTestingKit/SenTestingKit.h>

#import "Player.h"
#import "LookCommand.h"
#import "Item.h"
#import "Inventory.h"
#import "Bag.h"

@interface LookCommand_test : SenTestCase {
    Player          *_player;
    LookCommand     *_cmds;
    Inventory       *_inv;
}

@end

@implementation LookCommand_test

- (void)setUp
{
    _player = new Player("Fred", "Fred the mighty programmer");
    _cmds   = new LookCommand();
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

- (void)test__look_at_me
{
    // Create comparison strings
    NSString *expected = @"pen\nshovel\nsword\nwallet\n";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","me"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
}

- (void)test__look_at_sword
{
    // Create comparison strings
    NSString *expected = @"A very sharp sword";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","sword"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
}

- (void)test__look_at_sword_after_take
{
    // Take the word
    _inv->take("sword");
    
    // Now repeat
    NSString *expected = @"Couldn't find the sword";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","sword"}).c_str());
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
}


- (void)test__look_at_sword_in_inv
{
    // Create comparison strings
    NSString *expected = @"A very sharp sword";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","sword","in","inventory"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
}

- (void)test__look_at_cash_in_bag
{
    // Create comparison strings
    NSString *expected = @"A twenty dollar note";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","cash","in","wallet"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
}

- (void)test__look_at_cash_no_bag
{
    // Take the word
    Item* wallet = _inv->take("wallet");
    
    // Create comparison strings
    NSString *expected = @"Couldn't find the wallet";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","cash","in","wallet"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
    
    // Put the wallet back for next time
    _inv->put(wallet);
}


- (void)test__look_at_no_item_in_bag
{
    // Create comparison strings
    NSString *expected = @"Couldn't find the banana";
    NSString *actual   = @(_cmds->execute(_player, {"look","at","banana","in","wallet"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
}


- (void)test__invalid_look
{
    // Create comparison strings
    NSString *expected = @"What should I look at?";
    NSString *actual   = @(_cmds->execute(_player, {"look","banana"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
    
    expected = @"I don't understand that.";
    actual   = @(_cmds->execute(_player, {"hello"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);
    
    expected = @"What should I look in?";
    actual   = @(_cmds->execute(_player, {"look","at","a","at","b"}).c_str());
    
    STAssertEqualObjects(expected, actual, @"Expected %s, recieved %s", expected, actual);

}

@end
