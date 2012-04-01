//
//  RICItem.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/13/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICItem.h"

@interface RICItem (Private)
@end

@implementation RICItem

@synthesize name=_name,code=_code;

+(RICItem *)findItemWithCode:(NSInteger)code
{
    return [[RICDatabaseManager defaultManager] itemWithCode:code];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(NSString *)itemImageName
{
    return [[self name] 
            stringByReplacingOccurrencesOfString:@" " withString:@"_"];
}

-(NSImage *)icon
{
    return [NSImage imageNamed:[self itemImageName]];
}

-(NSString *)codeString
{
    return [NSString stringWithFormat:@"%i",_code];
}

#pragma mark -
#pragma mark Private

- (void)dealloc
{
    [super dealloc];
}

@end
