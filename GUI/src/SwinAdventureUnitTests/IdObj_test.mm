/**
 * @test    Identifiable Object
 * @version 1.0
 * @file    IdObj_test.mm
 * @author  Alex Cummaudo
 * @date    19 Sept 2013
 * @brief   Implements unit testing of an Identifiable Object
 */

#import <SenTestingKit/SenTestingKit.h>

#import "IdObj.h"

@interface IdObj_test : SenTestCase

@end

@implementation IdObj_test

/**
 * @note    I will use my own Obj-C syntax test__method_name
 *          since it makes it easier for me to to the right
 *          method (with different, C++ syntax)
 */

- (void)test__constructor
{
    // Create some ids
    vector<string> ids;
    ids.push_back("pen");
    ids.push_back("biro");
    
    // Then add it to idObj
    IdObj *newIdObj = new IdObj(ids);
    
    // To get around Obj-C objects and C++ objects
    // use a result variable and test if true or not
    // (Obj-C required an ID object, which doesn't exist
    //  in C++!!)
    BOOL result = true;
    if (newIdObj) result = false;
    STAssertFalse(result, @"Test creation of IdObj was not successful.");
}

- (void)test__are_you_a
{
    // Create some ids
    vector<string> ids;
    ids.push_back("pen");
    ids.push_back("biro");
    
    // Then add it to idObj
    IdObj *newIdObj = new IdObj(ids);
    
    // Now test the items
    STAssertTrue   (newIdObj->are_you_a("pen"),     @"Testing for pen did not result true!");
    STAssertTrue   (newIdObj->are_you_a("biro"),    @"Testing for biro did not result true!");
    STAssertFalse  (newIdObj->are_you_a("PeN"),     @"Testing for case-sensitive PeN did not result false!");
    STAssertFalse  (newIdObj->are_you_a("banana"),  @"Testing for non-existing `banana' did not return false!");
}

-(void)test__first_id
{
    // Create some ids
    vector<string> ids;
    ids.push_back("pen");
    ids.push_back("biro");

    // Then add it to idObj
    IdObj *newIdObj = new IdObj(ids);

    // Create comparison strings
    NSString *expected = @"pen";
    NSString *actual   = @(newIdObj->first_id().c_str());   // *** Use notation @(c++string.c_str()); to convert to NSString ***
    
    STAssertEqualObjects(expected, actual, @"Returning first ID was not successful");
}

-(void)test__add_identifier
{
    // Create some ids
    vector<string> ids;
    ids.push_back("pen");
    ids.push_back("biro");
    
    // Then add it to the idObj
    IdObj *newIdObj = new IdObj(ids);
    
    // Create some more ids
    string newIdOne = "banana";
    string newIdTwo = "ShOvEL"; // Will be inserted as shovel
    
    // Add it to newIdObj
    newIdObj->add_id(newIdOne);
    newIdObj->add_id(newIdTwo); // Insert as `shovel'
    
    // Test that all have been successfully added
    STAssertTrue    (newIdObj->are_you_a("pen"),        @"Testing for pen did not return true!");
    STAssertTrue    (newIdObj->are_you_a("biro"),       @"Testing for biro did not return true!");
    STAssertTrue    (newIdObj->are_you_a("banana"),     @"Testing for banana did not return true!");
    STAssertTrue    (newIdObj->are_you_a("shovel"),     @"Testing for shovel (properly converted to l/c) did not return true!");
}

@end
