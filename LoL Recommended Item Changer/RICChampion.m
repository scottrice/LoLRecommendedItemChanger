//
//  RICChampion.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/13/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICChampion.h"

@interface RICChampion (Private)
@end

@implementation RICChampion

@synthesize name=_name,championDescription=_championDescription,nameCode=_nameCode;

+(void)initialize
{
    if(self != [RICChampion class])
        return;
}

+(id)findChampionWithNameCode:(NSString *)nameCode
{
    return [[RICDatabaseManager defaultManager] championWithNameCode:nameCode];
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(NSImage *)icon
{
    return [NSImage imageNamed:[self nameCode]];
}

-(BOOL)isEqual:(id)object {
    RICChampion *other = (RICChampion *)object;
    return  [[self name] isEqual:[other name]] &&
            [[self nameCode] isEqual:[other nameCode]] &&
            [[self championDescription] isEqual:[other championDescription]];
}

#pragma mark -
#pragma mark Private

-(NSString *)description {
    return [self name];
}

- (void)dealloc
{
    [super dealloc];
}

@end
