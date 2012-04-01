//
//  RICCollectionViewItem.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/23/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICCollectionViewItem.h"


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

-(void)setSelected:(BOOL)flag {
    [super setSelected:flag];
    if(flag) {
        //  Determine whether the use selected a champion or an item, and
        //  inform the delegate accordingly
        if([[self representedObject] isKindOfClass:[RICChampion class]])
            [[self delegate] selectChampion:(RICChampion *)[self representedObject]];
        if([[self representedObject] isKindOfClass:[RICItem class]])
            [[self delegate] selectItem:(RICItem *)[self representedObject]];
    }
}

- (void)dealloc
{
    [super dealloc];
}

-(id)copyWithZone:(NSZone *) zone {
    RICCollectionViewItem *newItem = [super copyWithZone:zone];//[[RICCollectionViewItem allocWithZone:zone] init];
    [newItem setDelegate:[self delegate]];
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
