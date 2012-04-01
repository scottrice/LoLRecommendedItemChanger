//
//  RICINIManagerTest.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 3/31/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import "RICINIManager.h"

@interface RICINIManagerTest : GHTestCase {
    NSArray *_spamToppyItems;
    NSString *_spamToppyString;
}
@end

@implementation RICINIManagerTest

- (BOOL)shouldRunOnMainThread {
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES.
    // Also an async test that calls back on the main thread, you'll probably want to return YES.
    return NO;
}

- (void)setUpClass {
    _spamToppyItems = [NSArray arrayWithObjects:[RICItem findItemWithCode:3078],
                                                [RICItem findItemWithCode:3110],
                                                [RICItem findItemWithCode:3146],
                                                [RICItem findItemWithCode:3140],
                                                [RICItem findItemWithCode:3031],
                                                [RICItem findItemWithCode:3069], nil];
    _spamToppyString = @"[ItemSet1]\nSetName=Set1\nRecItem1=3078\nRecItem2=3110\nRecItem3=3146\nRecItem4=3140\nRecItem5=3031\nRecItem6=3069";
}

- (void)tearDownClass {
    // Run at end of all tests in the class
}

- (void)setUp {
    // Run before each test method
}

- (void)tearDown {
    // Run after each test method
}   

-(void)testGenerateINIStringForItemCodes {
    NSString *stringValue = [RICINIManager generateINIStringForItemCodes:_spamToppyItems];
    GHAssertEqualStrings(stringValue, _spamToppyString, @"The generated string should be the same as SpamToppy");
}

-(void)testReadItemsFromINIString {
    NSArray *readItems = [RICINIManager readItemsFromINIString:_spamToppyString];
    GHAssertEqualObjects(readItems, _spamToppyItems, @"The read items should be the same as the SpamHappy items");
}

@end
