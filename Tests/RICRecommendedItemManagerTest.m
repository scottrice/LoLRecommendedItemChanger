//
//  RICRecommendedItemManagerTest.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 3/31/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import <GHUnit/GHUnit.h>
#import "RICRecommendedItemManager.h"

@interface RICRecommendedItemManagerTest : GHTestCase { 
    NSArray *_spamToppyItems;
}
@end

@implementation RICRecommendedItemManagerTest

- (BOOL)shouldRunOnMainThread {
    // By default NO, but if you have a UI test or test dependent on running on the main thread return YES.
    // Also an async test that calls back on the main thread, you'll probably want to return YES.
    return NO;
}

- (void)setUpClass {
    //  These items are from SpamHappy's Poppy guide :P
    _spamToppyItems = [NSArray arrayWithObjects:[RICItem findItemWithCode:3078],
                                                [RICItem findItemWithCode:3110],
                                                [RICItem findItemWithCode:3146],
                                                [RICItem findItemWithCode:3140],
                                                [RICItem findItemWithCode:3031],
                                                [RICItem findItemWithCode:3069], nil];
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

-(void)testSetRecommendedItemsForChampion {
    //  When I call this method. If I were to make a new instance using the same champion
    //  and were to check the items, I would be using custom items and the items would be the same that I set
    RICChampion *poppy = [RICChampion findChampionWithNameCode:@"Poppy"];
    [RICRecommendedItemManager setRecommendedItems:_spamToppyItems forChampion:poppy];
    //  Now that those are set, lets check them...
    RICRecommendedItemManager *poppyManager = [[RICRecommendedItemManager alloc] initWithChampion:poppy];
    GHAssertTrue([poppyManager isUsingCustomItems],@"After setting those items, Poppy should be using custom items");
    GHAssertEqualObjects([poppyManager items],_spamToppyItems,@"The items should be set as the SpamHappy guide");
}

-(void)testIsUsingCustomItems {
    RICRecommendedItemManager *akaliManager = [[RICRecommendedItemManager alloc] initWithChampion:[RICChampion findChampionWithNameCode:@"Akali"]];
    [akaliManager clearRecommendedItems];
    GHAssertFalse([akaliManager isUsingCustomItems], @"I just cleared the items, this should be false");
    //  Using the same items as above, as I don't really care about Akali
    [akaliManager setItems:_spamToppyItems];
    GHAssertTrue([akaliManager isUsingCustomItems],@"I just set the items, this should be true");
}

//  Not testing the items method, because I see no way to test setItems and items
//  without using both, so why not combine to just the setItems test
-(void)testSetItems {
    RICRecommendedItemManager *karmaManager = [[RICRecommendedItemManager alloc] initWithChampion:[RICChampion findChampionWithNameCode:@"Karma"]];
    [karmaManager clearRecommendedItems];
    GHAssertNil([karmaManager items],@"Should return nil when there are no recommended items");
    //  Using the same items as above, as I don't really care about Karma either
    [karmaManager setItems:_spamToppyItems];
    GHAssertEqualObjects([karmaManager items],_spamToppyItems,@"I just set these items so they should be equal");
}

-(void)testClearRecommendedItems {
    RICRecommendedItemManager *kayleManager = [[RICRecommendedItemManager alloc] initWithChampion:[RICChampion findChampionWithNameCode:@"Kayle"]];
    //  Well, you know the drill...
    [kayleManager setItems:_spamToppyItems];
    GHAssertEqualObjects([kayleManager items],_spamToppyItems,@"I just set these items so they should be equal");
    [kayleManager clearRecommendedItems];
    GHAssertNil([kayleManager items],@"Should return nil when there are no recommended items");
    GHAssertFalse([kayleManager isUsingCustomItems], @"After clearing, it should say I'm not using custom items");
}

@end