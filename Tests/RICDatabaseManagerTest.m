//
//  RICDatabaseManagerTest.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 3/31/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import <GHUnit/GHUnit.h>

#import "RICDatabaseManager.h"
#import "RICChampion.h"
#import "RICItem.h"

@interface RICDatabaseManagerTest : GHTestCase { }
@end

@implementation RICDatabaseManagerTest

-(void)testIsSingleton {
    GHAssertTrue([RICDatabaseManager defaultManager] == [RICDatabaseManager defaultManager],@"Two calls to defaultManager should return the same thing");
}

-(void)testAllChampions {
    
}

-(void)testAllItems {
    
}

-(void)testChampionWithNameCode {
    RICChampion *kayle = [[RICDatabaseManager defaultManager] championWithNameCode:@"Kayle"];
    GHAssertEqualStrings(@"Kayle", [kayle name], @"Regular champions are not handled correctly");
    //  Test a champion with spaces
    RICChampion *mundo = [[RICDatabaseManager defaultManager] championWithNameCode:@"DrMundo"];
    GHAssertEqualStrings(@"Dr. Mundo", [mundo name], @"Spaces are not handled correctly");
    //  Test a champion with special characters
    RICChampion *cho = [[RICDatabaseManager defaultManager] championWithNameCode:@"ChoGath"];
    GHAssertEqualStrings(@"Cho'Gath", [cho name], @"Special Characters are not handled correctly");
}

-(void)testItemWithCode {
    RICItem *warmogs = [[RICDatabaseManager defaultManager] itemWithCode:3083];
    GHAssertEqualStrings(@"Warmog's Armor", [warmogs name], @"Loaded Warmogs doesn't have same name");
    RICItem *atmas = [[RICDatabaseManager defaultManager] itemWithCode:3005];
    GHAssertEqualStrings(@"Atma's Impaler", [atmas name], @"Loaded Atmas doesn't have same name");
    RICItem *doransring = [[RICDatabaseManager defaultManager] itemWithCode:1056];
    GHAssertEqualStrings(@"Doran's Ring", [doransring name], @"Loaded Doran's Ring doesn't have same name");
}

@end
