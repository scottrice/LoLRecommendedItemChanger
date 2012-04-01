//
//  RICChampionTest.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 3/31/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import "RICChampion.h"

@interface RICChampionTest : GHTestCase { }
@end

@implementation RICChampionTest

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

-(void)testIcon {
    RICChampion *ahri = [RICChampion findChampionWithNameCode:@"Ahri"];
    GHAssertEquals([NSImage imageNamed:@"Ahri"],[ahri icon],@"");
    RICChampion *mundo = [RICChampion findChampionWithNameCode:@"DrMundo"];
    GHAssertEquals([NSImage imageNamed:@"DrMundo"],[mundo icon],@"");
}

-(void)testFindChampionWithNameCode {
    RICChampion *ahri = [RICChampion findChampionWithNameCode:@"Ahri"];
    GHAssertEqualStrings(@"Ahri", [ahri name], @"");
    GHAssertEqualStrings(@"The Nine-Tailed Fox", [ahri championDescription], @"");
    RICChampion *mundo = [RICChampion findChampionWithNameCode:@"DrMundo"];
    GHAssertEqualStrings(@"Dr. Mundo", [mundo name], @"");
    GHAssertEqualStrings(@"The Madman of Zaun", [mundo championDescription], @"");
}

@end