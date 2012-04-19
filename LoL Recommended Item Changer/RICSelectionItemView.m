//
//  RICSelectionItemView.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 4/9/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import "RICSelectionItemView.h"


@implementation RICSelectionItemView

@synthesize collectionItem=_collectionItem;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSRect backgroundRect = NSMakeRect(5,5,110,110);
    NSColor *border = RICIMAGEVIEWBORDERCOLOR;
    [border set];
    NSRectFill(backgroundRect);
}

#pragma mark -
#pragma mark Detecting mouse events (for intelligent dragging and dropping)

-(void)setIsDrag {
//    _aRealDrag = YES;
}


/*/
 *  Turns out I actually CANT implement Drag and Drop along with just selecting images in order. That is because
 *  of some LEGENDARY stupidity on Apple's part. If I call [super mouseDown:theEvent], then mouseUp doesnt get called,
 *  but dragging and dropping works. For more information, check out this thread:
 *  
 *  http://www.cocoabuilder.com/archive/cocoa/106670-mouseup-not-called-in-nstableview-subclass-when-mousedown-is-overridden.html
/*/
-(void)mouseDown:(NSEvent *)theEvent {
    _aRealDrag = NO;
}

-(void)mouseUp:(NSEvent *)theEvent {
    if(!_aRealDrag) {
        //  Determine whether the use selected a champion or an item, and
        //  inform the delegate accordingly
        if([[_collectionItem representedObject] isKindOfClass:[RICChampion class]])
            [[_collectionItem delegate] selectChampion:(RICChampion *)[_collectionItem representedObject]];
        if([[_collectionItem representedObject] isKindOfClass:[RICItem class]])
            [[_collectionItem delegate] selectItem:(RICItem *)[_collectionItem representedObject]];
    }
}

@end
