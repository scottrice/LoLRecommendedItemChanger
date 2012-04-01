//
//  RICSelectedItemView.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 3/30/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RICItem.h"

@interface RICSelectedItemView : NSView {
@private
    IBOutlet NSImageView *_itemIconView;
    IBOutlet NSTextField *_itemNameLabel;
    RICItem *_item;
}

@property(nonatomic,retain) RICItem *item;

@end
