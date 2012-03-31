//
//  RICRecommendedItemManager.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 11/8/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RICINIManager.h"
#import "RICChampion.h"
#import "RICItem.h"


@interface RICRecommendedItemManager : NSObject {
@private
    NSString *_championDirectory;
    RICChampion *_champion;
    NSArray *_items;
}

//  Shortcut method to make handling this class extremely easy
+(BOOL)setRecommendedItems:(NSArray *)items forChampion:(RICChampion *)character;
//  Managing the location of the LoL App file (as far as the program is concerned)
+(NSString *)LOLAppFilePath;
+(void)setLOLAppFilePath:(NSString *)path;

-(id)initWithChampion:(RICChampion *)champion;

-(BOOL)isUsingCustomItems;

-(NSArray *)items;
-(BOOL)setItems:(NSArray *)items;

-(BOOL)clearRecommendedItems;

@end
