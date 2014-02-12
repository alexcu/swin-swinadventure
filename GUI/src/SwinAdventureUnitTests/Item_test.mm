/**
 * @test    Item
 * @version 1.0
 * @file    Item_test.mm
 * @author  Alex Cummaudo
 * @date    20 Sept 2013
 * @brief   Implements unit testing of an Game Item
 */

#import <SenTestingKit/SenTestingKit.h>

#import "Item.h"

@interface Item_test : SenTestCase

@end

@implementation Item_test

/**
 * @note    I will use my own Obj-C syntax test__method_name
 *          since it makes it easier for me to to the right
 *          method (with different, C++ syntax)
 */

- (void)test__are_you_a
{
    
    // Create some ids
    vector<string> ids;
    ids.push_back("shovel");
    ids.push_back("digger");
    ids.push_back("spade");
    
    Item *itm = new Item(ids, "Shovel", "A simple shovel to dig with");
    
    STAssertTrue(itm->are_you_a("digger"), @"Did not respond truly to digger");
    STAssertTrue(itm->are_you_a("shovel"), @"Did not respond truly to shovel");
    STAssertTrue(itm->are_you_a("spade"), @"Did not respond truly to spade");
    STAssertFalse(itm->are_you_a("tomato"), @"Responded truly for non-existant id tomato");
    
}

- (void)test__get_short_description
{
    // Create some ids
    vector<string> ids;
    ids.push_back("shovel");
    ids.push_back("digger");
    ids.push_back("spade");
    
    Item *itm = new Item(ids, "A small shovel", "A simple shovel to dig with");
    
    // Create comparison strings
    NSString *expected = @"A small shovel (shovel)";
    NSString *actual   = @(itm->get_short_desc().c_str());
    
    STAssertEqualObjects(expected, actual, @"Short description was correct: expected %s, recieved %s", expected, actual);
}

-(void) test__get_full_description
{
    // Create some ids
    vector<string> ids;
    ids.push_back("shovel");
    ids.push_back("digger");
    ids.push_back("spade");
    
    Item *itm = new Item(ids, "A small shovel", "A simple shovel to dig with.");
    
    // Create comparison strings
    NSString *expected = @"A simple shovel to dig with.";
    NSString *actual   = @(itm->get_full_desc().c_str());
    
    STAssertEqualObjects(expected, actual, @"Short description was incorrect: expected %@, recieved %@", expected, actual);
}

@end
