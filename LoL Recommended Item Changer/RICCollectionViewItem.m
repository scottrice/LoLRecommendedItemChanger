//
//  RICCollectionViewItem.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/23/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICCollectionViewItem.h"

void nop() {
    
}

@implementation RICCollectionViewItem

@synthesize iconView=_iconView,label=_label, delegate=_delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];
    //  I apparently didn't hook up the icon view in Interface
    //  Builder correctly, so it is nil when this method is called.
    //  No idea why, but I am going to hack my way around it by taking
    //  an array of subviews and setting iconView to the first one.
    //
    //  TODO: Make this not break when I change the interface (aka do it right)
    if(!_iconView)
    {
        _iconView = [[[self view] subviews] objectAtIndex:0];
    }
    [[self iconView] setImage:[representedObject icon]];
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark Copying (for use in the NSCollectionView)

-(id)copyWithZone:(NSZone *) zone {
    RICCollectionViewItem *newItem = [super copyWithZone:zone];
    [newItem setDelegate:[self delegate]];
    [(RICSelectionItemView *)[newItem view] setCollectionItem:newItem];
    return newItem;
}

//  NSCoding compliance
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
}

@end
