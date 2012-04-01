//
//  RICSelectedItemView.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 3/30/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import "RICSelectedItemView.h"

@interface RICSelectedItemView (Private)

-(void)_updateIcon;
-(void)_updateName;

@end

@implementation RICSelectedItemView

@synthesize item=_item;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib {
    //  Since setItem checks to make sure _item isnt the same as the parameter,
    //  I am going to set _item to a bullshit value so it will set the value as
    //  nil
    _item = [RICItem new];
    [self setItem:nil];
}

-(void)setItem:(RICItem *)item {
    if(item != _item) {
        [_item release];
        _item = item;
        [_item retain];
        [self _updateIcon];
        [self _updateName];
    }
}

-(void)_updateIcon {
    NSImage *icon = [_item icon];
    //  Set the default image if the item is nil
    if(!_item)
        icon = [NSImage imageNamed:@"UnknownItem"];
    [_itemIconView setImage:icon];
}

-(void)_updateName {
    NSString *name = [_item name];
    //  Set the default icon if the item is nil
    if(!_item)
        name = @"  ?";
    [_itemNameLabel setStringValue:name];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

@end
