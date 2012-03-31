//
//  RICDatabaseManager.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/13/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "RICChampion.h"
#import "RICItem.h"

@class RICChampion;
@class RICItem;

NSString *RICLOLDatabaseLocation();

@interface RICDatabaseManager : NSObject {
@private
    NSArray *_champions;
    NSArray *_items;
    
    //  DB Stuff
    sqlite3 *_db;
    //	Used during executeQuery
	NSMutableDictionary *_tempDict;
}

+(id)defaultManager;

-(NSArray *)allChampions;
-(RICChampion *)championWithNameCode:(NSString *)nameCode;

-(NSArray *)allItems;
-(RICItem *)itemWithCode:(NSInteger)code;

//  Ssshhhh, this is supposed to be private
@property(nonatomic,retain)NSMutableDictionary *tempDict;

@end
