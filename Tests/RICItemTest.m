//
//  RICItemTest.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 3/31/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import "RICItem.h"

@interface RICItemTest : GHTestCase { }
@end

@implementation RICItemTest

- (BOOL)shouldRunOnMainThread {
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES.
    // Also an async test that calls back on the main thread, you'll probably want to return YES.
    return NO;
}

- (void)setUpClass {
    // Run at start of all tests in the class
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

-(void)testItemImageName {
    RICItem *warmogs = [RICItem findItemWithCode:3083];
    GHAssertEqualStrings(@"Warmog's_Armor",[warmogs itemImageName], @"");
}

-(void)testIcon {
    RICItem *warmogs = [RICItem findItemWithCode:3083];
    GHAssertEquals([NSImage imageNamed:@"Warmog's_Armor"],[warmogs icon], @"");
}

-(void)testCodeString {
    RICItem *warmogs = [RICItem findItemWithCode:3083];
    GHAssertEqualStrings(@"3083", [warmogs codeString], @"");
}

-(void)testFindItemWithCode {
    RICItem *warmogs = [RICItem findItemWithCode:3083];
    GHAssertEqualStrings(@"Warmog's Armor", [warmogs name], @"Loaded Warmogs doesn't have same name");
    RICItem *atmas = [RICItem findItemWithCode:3005];
    GHAssertEqualStrings(@"Atma's Impaler", [atmas name], @"Loaded Atmas doesn't have same name");
    RICItem *doransring = [RICItem findItemWithCode:1056];
    GHAssertEqualStrings(@"Doran's Ring", [doransring name], @"Loaded Doran's Ring doesn't have same name");
}

-(void)testIsEqual {
    //  Fake item that we will test on
    RICItem *master = [RICItem new];
    [master setName:@"Mirage's Ring"];
    [master setCode:9001];
    RICItem *hopeful = [RICItem new];
    GHAssertFalse([hopeful isEqual:master],@"None of the ivars are the same");
    [hopeful setCode:9001];
    GHAssertFalse([hopeful isEqual:master],@"The code isnt the same");
    [hopeful setName:@"Mirage's Ring"];
    GHAssertTrue([hopeful isEqual:master],@"Everything is the same");
    [hopeful setName:@"Not Mirage's Ring"];
    GHAssertFalse([hopeful isEqual:master],@"The name isnt the same");
}

@end
