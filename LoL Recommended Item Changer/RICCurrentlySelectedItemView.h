//
//  RICSelectedItemView.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 3/30/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RICConstants.h"
#import "RICItem.h"

@interface RICCurrentlySelectedItemView : NSView {
@private
    IBOutlet NSImageView *_itemIconView;
    IBOutlet NSTextField *_itemNameLabel;
    IBOutlet NSImageView *_selectedImageView;
    RICItem *_item;
    
    BOOL _isCurrentItem;
    
    id _target;
    SEL _action;
}

@property(nonatomic,retain) RICItem *item;
@property(nonatomic,assign) BOOL isCurrentItem;

// Control methods
@property(nonatomic,assign)id target;
@property(nonatomic,assign)SEL action;

@end
