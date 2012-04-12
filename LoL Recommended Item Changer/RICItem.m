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
    return [[[self name] 
            stringByReplacingOccurrencesOfString:@" " withString:@"_"]
            stringByReplacingOccurrencesOfString:@"." withString:@""];
}

-(NSImage *)icon
{
    return [NSImage imageNamed:[self itemImageName]];
}

-(NSString *)codeString
{
    return [NSString stringWithFormat:@"%i",_code];
}

-(BOOL)isEqual:(id)object {
    if(![object isKindOfClass:[RICItem class]])
        return NO;
    RICItem *other = (RICItem *)object;
    return  [[self name] isEqual:[other name]] && [self code] == [other code];
}

#pragma mark -
#pragma mark Private

- (void)dealloc
{
    [super dealloc];
}

@end
