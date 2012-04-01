//
//  RICChampion.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/13/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RICDatabaseManager.h"


@interface RICChampion : NSObject {
@private
    NSString *_name;
    NSString *_championDescription;
    //  For most champions, this is just the name. It really is only important
    //  for champions like Miss Fortune or Dr Mundo, who have spaces in their name
    NSString *_nameCode;
}

+(RICChampion *)findChampionWithNameCode:(NSString *)nameCode;

-(NSImage *)icon;

//  For the most part, you should never have to edit these
//  Champions should be returned from the database already
//  initialized with the correct data
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *championDescription;
@property(nonatomic,copy)NSString *nameCode;

@end
