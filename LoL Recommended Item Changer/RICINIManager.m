//
//  RICINIGenerator.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/13/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICINIManager.h"

#define codeStringFromUnknownType(index) [RICINIManager _codeFromObject:[items objectAtIndex:index]]

@interface RICINIManager (Private)

+(NSString *)_codeFromObject:(id)object;

@end

@implementation RICINIManager

+(NSString *)generateINIStringForItemCodes:(NSArray *)items
{
    if([items count] != 6)
        return nil;
    return [NSString stringWithFormat:@"[ItemSet1]\nSetName=Set1\nRecItem1=%@\nRecItem2=%@\nRecItem3=%@\nRecItem4=%@\nRecItem5=%@\nRecItem6=%@",
            codeStringFromUnknownType(0),
            codeStringFromUnknownType(1),
            codeStringFromUnknownType(2),
            codeStringFromUnknownType(3),
            codeStringFromUnknownType(4),
            codeStringFromUnknownType(5)];
}

+(NSArray *)readItemsFromINIString:(NSString *)string
{
    //  Strategy: Start by finding where the beginning of the list of recommended items is
    //  (I believe SetName and ItemSet can never change, but can't be too careful). Once
    //  we have the starting location, since we know the length of the prefix (RecItemX=),
    //  and we know the length of the item code (it is always length 4), we will just keep
    //  incrementing an index variable to find the start of the item codes. Then we take the
    //  intvalue, throw it in an array, and we are good to go!
    NSRange range;
    NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:6];
    for(NSInteger i = 0 ; i < 6 ; i++)
    {
        range = [string rangeOfString:[NSString stringWithFormat:@"RecItem%i=",i+1]];
        //  range.location + range.length should give us the index of the first character after
        //  the string 'RecItemX', which should be the start of the item code
        [ret addObject:[RICItem findItemWithCode:[[string substringWithRange:NSMakeRange(range.location + range.length, 4)] intValue]]];
    }
    return ret;
}


//  I'm mainly implementing this functionality (letting the INI generator take an array of strings OR an array of RICItems)
//  because when I do my testing, it takes WAY too long to type out [RICItem itemWithCode:@"3111"] six times. When the app
//  is done, it should be passing around RICItem objects, so hopefully this feature won't be used much.
//
//  Also, even though I doubt I'll ever use it, I'll let them pass in an array of NSNumber objects as well
+(NSString *)_codeFromObject:(id)object
{
    if([object isKindOfClass:[RICItem class]])
        return [object codeString];
    if([object isKindOfClass:[NSString class]])
        return object;
    if([object isKindOfClass:[NSNumber class]])
        return [object stringValue];
    return @"";
}

@end
