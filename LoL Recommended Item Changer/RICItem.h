//
//  RICItem.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/13/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RICDatabaseManager.h"


@interface RICItem : NSObject {
@private
    NSString *_name;
    NSInteger _code;
}

+(RICItem *)findItemWithCode:(NSInteger)code;

-(NSString *)codeString;

@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger code;

@end
