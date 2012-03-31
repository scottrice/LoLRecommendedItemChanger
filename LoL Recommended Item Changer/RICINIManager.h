//
//  RICINIGenerator.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/13/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RICItem.h"


@interface RICINIManager : NSObject {
@private
    
}

+(NSString *)generateINIStringForItemCodes:(NSArray *)items;
+(NSArray *)readItemsFromINIString:(NSString *)string;

@end
