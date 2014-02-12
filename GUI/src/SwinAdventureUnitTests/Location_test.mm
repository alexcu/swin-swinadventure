/**
 * @test    Location Test
 * @version 1.0
 * @file    Location_test.mm
 * @author  Alex Cummaudo
 * @date    12 Oct 2013
 * @brief   Implements unit testing of a Locations
 */

#import <SenTestingKit/SenTestingKit.h>

#import "Player.h"
#import "Location.h"
#import "Item.h"
#import "Bag.h"
#import "Inventory.h"
#import "Path.h"

@interface Location_test : SenTestCase
{
    Player*     _player;
    Inventory*  _invPlayer;
    
    Location*   _city;
    Inventory*  _invCity;
    
    Location*   _beach;
    Inventory*  _invBeach;
    
    Location*   _countryside;
    Inventory*  _invCountryside;
    
    
}

@end

@implementation Location_test

- (void)setUp
{
    [super setUp];
    
    
    /**
     * Setup player; add a wallet
     */
    _player = new Player("Fred", "The lonely programmer");
    _invPlayer = _player->get_inventory();
    
    // Create a second bag with some items
    Bag *wallet = new Bag({"wallet"}, "wallet", "A leather wallet");
    
    // Create some random items
    Item *myki = new Item({"myki"}, "A myki card", "A concession myki card");
    Item *cash = new Item({"cash", "money", "notes"}, "Some cash", "A twenty dollar note");
    Item *idcard = new Item({"id"}, "An id card", "A standard drivers license");
    
    // Add the items to the wallet
    Inventory *invWallet = wallet->get_inventory();
    invWallet->put(myki);
    invWallet->put(cash);
    invWallet->put(idcard);
    
    // Add the wallet to the player's inventory
    _invPlayer->put(wallet);

    /**
     * Setup city with items
     */
    _city = new Location({"city"}, "New York City", "The Big Apple");
    _invCity = _city->get_inventory();
    Item *taxi = new Item({"taxi", "car"}, "Taxi", "A yellow taxi cab");
    Item *subway = new Item({"subway", "train"}, "Subway", "A subway train");
    _invCity->put(taxi);
    _invCity->put(subway);
    
    /**
     * Setup beach with items
     */
    _beach = new Location({"beach"}, "McCrae Beach", "Small beach");
    _invBeach = _beach->get_inventory();
    Item *beachball = new Item({"beachball", "ball"}, "Beachball", "Rainbow beachball");
    Item *pier = new Item({"pier", "deck"}, "Pier", "A pier");
    _invBeach->put(beachball);
    _invBeach->put(pier);
    
    /**
     * Setup countryside with items
     */
    _countryside = new Location({"countryside"}, "Wattle Glen", "Country town");
    _invCountryside = _countryside->get_inventory();
    Item *tractor = new Item({"tractor", "car"}, "Tractor", "A rusty tractor");
    Item *crop = new Item({"crop"}, "crop", "A wheat crop");
    _invCountryside->put(tractor);
    _invCountryside->put(crop);
}

- (void)test__location_locate
{

    STAssertTrue(_city->locate("taxi"), @"City did not respond to locating its taxi");
    STAssertTrue(_beach->locate("beachball"), @"Beach did not respond to locating its beachball");
    STAssertTrue(_countryside->locate("tractor"), @"Country did not respond to locating its tractor");

    STAssertFalse(_city->locate("apple"), @"City did respond to locating non-existant item");
    STAssertFalse(_beach->locate("banana"), @"Beach did respond to locating non-existant item");
    STAssertFalse(_countryside->locate("carrot"), @"Country did respond to locating non-existant item");

    STAssertTrue(_city->locate("city"), @"City did not respond to locating itself");
    STAssertTrue(_beach->locate("beach"), @"Beach did not respond to locating itself");
    STAssertTrue(_countryside->locate("countryside"), @"Country did not respond to locating itself");
    
}

-(void)test__player_locateable_items
{
    // Put the player in the city
    _player->set_location(_city);
    
    // Check if player can locate subway in city
    STAssertTrue(_player->locate("subway"), @"Player did not respond to locating subway in the city");

    // Check if player locates crop from countryside
    STAssertFalse(_player->locate("crop"), @"Player responded to locating crop that doesn't exist in the city");
    
    // Put the player in the city
    _player->set_location(_countryside);
    
    // Check if player can locate beachball from beach in countryside
    STAssertFalse(_player->locate("beachball"), @"Player responded to locating beachball in the countryside");
    
    // Check if player locates crop from countryside
    STAssertTrue(_player->locate("crop"), @"Player did not respond to locating existant crop in countryside");

    // Put the player in the beach
    _player->set_location(_beach);
    
    // Check if player can locate non-existant items
    STAssertFalse(_player->locate("banana"), @"Player responded to locating non-existant item");
}

-(void)test__find_paths
{
    // Put the player in the city
    _player->set_location(_city);

    Path* tram = new Path({"tram"}, "tram", "A tram to the beach", _beach, true);
    
    // Add the tram to the city
    _city->add_path(tram);
    
    // Check locating a tram
    STAssertTrue(_city->locate("tram"), @"Couldn't find path for tram");
    
    // Check locating non existing item
    STAssertFalse(_city->locate("banana"), @"Found non-existant item banana");
    
}

@end
