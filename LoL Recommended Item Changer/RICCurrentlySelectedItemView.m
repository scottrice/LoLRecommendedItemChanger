//
//  RICSelectedItemView.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 3/30/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import "RICCurrentlySelectedItemView.h"

@interface RICCurrentlySelectedItemView (Private)

-(void)_updateIcon;
-(void)_updateName;

@end

@implementation RICCurrentlySelectedItemView

@synthesize item=_item,isCurrentItem=_isCurrentItem,target=_target,action=_action;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObject:RICITEMDRAGTYPE]];
        _selectedBackgroundImage = [NSImage imageNamed:@"BlueGradient"];
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

-(void)setIsCurrentItem:(BOOL)isCurrentItem {
    _isCurrentItem = isCurrentItem;
    _isCurrentItem ? [_itemNameLabel setTextColor:[NSColor whiteColor]] : [_itemNameLabel setTextColor:[NSColor blackColor]];
    [self setNeedsDisplay:YES];
}

-(void)drawRect:(NSRect)dirtyRect {
    if(_isHovering && !_isCurrentItem) {
        [_selectedBackgroundImage   drawInRect: [self bounds]
                                      fromRect: NSZeroRect
                                     operation: NSCompositeSourceOver
                                      fraction: 0.3];
    }
    if(_isCurrentItem) {
        [_selectedBackgroundImage   drawInRect: [self bounds]
                                    fromRect: NSZeroRect
                                    operation: NSCompositeSourceOver
                                    fraction: 1.0];
    }
    NSRect borderRect = NSInsetRect([_itemIconView frame], -5, -5);
    NSColor *borderColor = RICIMAGEVIEWBORDERCOLOR;
    [borderColor set];
    NSRectFill(borderRect);
}

#pragma mark -
#pragma mark Mouse Events (for selecting as current item and hoverability)

- (void) viewDidMoveToWindow {
    [self addTrackingRect:[self bounds]
                    owner:self
                 userData:nil
             assumeInside:NO];
}

-(void)mouseDown:(NSEvent *)theEvent {
    //  Call action on target passing in this object as a parameter
    [_target performSelector:_action withObject:self];
}

-(void)mouseEntered:(NSEvent *)theEvent {
    _isHovering = YES;
    [self setNeedsDisplay:YES];
}

-(void)mouseExited:(NSEvent *)theEvent {
    _isHovering = NO;
    [self setNeedsDisplay:YES];
}

#pragma mark -
#pragma mark Drag and Drop

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    return NSDragOperationGeneric;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSString *itemCode = [[sender draggingPasteboard] stringForType:RICITEMDRAGTYPE];
    RICItem *item = [RICItem findItemWithCode:[itemCode integerValue]];
    [self setItem:item];
    return YES;
}

- (void)dealloc
{
    [super dealloc];
}

@end
