//
//  RICCurrentSelectionViewController.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/21/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICCurrentSelectionViewController.h"

#define X_MARGIN 0
#define Y_VALUE_OF_FIRST_ITEM_VIEW 550

@implementation RICCurrentSelectionViewController

@synthesize championIconView=_championIconView,selectionViewController=_selectionController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"RICCurrentSelectionView" bundle:nibBundleOrNil];
    if (self) {
        _items = [[NSMutableArray arrayWithCapacity:NUMBER_OF_ITEMS] retain];
        _itemViews = [[NSMutableArray arrayWithCapacity:NUMBER_OF_ITEMS] retain];
        NSUInteger currentY = Y_VALUE_OF_FIRST_ITEM_VIEW;
        //  Create all the item views
        for(NSInteger i = 0 ; i < NUMBER_OF_ITEMS ; i++) {
            //  At least Apple learned with iOS, but the current nib loading interface is NOT a good one
            //  Anyway, load the nib and have the new view set as the _loadedCurrentItemView object
            [NSBundle loadNibNamed:@"RICSelectedItemView" owner:self];
            [_loadedCurrentItemView setFrameOrigin:CGPointMake(X_MARGIN, currentY)];
            [_loadedCurrentItemView setTarget:self];
            [_loadedCurrentItemView setAction:@selector(setItemViewAsCurrent:)];
            [[self view] addSubview:_loadedCurrentItemView];
            [_itemViews addObject:_loadedCurrentItemView];
            //  Set currentY to the correct value for the next iteration
            currentY -= [_loadedCurrentItemView frame].size.height;
        }
        for(NSInteger i = 0 ; i < NUMBER_OF_ITEMS ; i++) {
            [_items addObject:[NSNull null]];
        }
        [_championIconView setTarget:self];
        [_championIconView setAction:@selector(championPortraitClicked:)];
        [[_itemViews objectAtIndex:0] setIsCurrentItem:YES];
    }
    
    return self;
}

-(RICChampion *)champion {
    return _champion;
}

-(NSArray *)items {
    return _items;
}

-(void)setChampion:(RICChampion *)champion {
    if(_champion != champion) {
        [_champion release];
        _champion = champion;
        [_champion retain];
    }
    [_championIconView setImage:[champion icon]];
    [_championLabel setStringValue:[champion name]];
}

-(void)setItemViewAsCurrent:(RICCurrentlySelectedItemView *)itemView {
    NSUInteger index = [_itemViews indexOfObject:itemView];
    if(index != NSNotFound) {
        [[_itemViews objectAtIndex:_currentItemIndex] setIsCurrentItem:NO];
        _currentItemIndex = index;
        [itemView setIsCurrentItem:YES];
    }
}

-(void)setNextItem:(RICItem *)item {
    [[_itemViews objectAtIndex:_currentItemIndex] setIsCurrentItem:NO];
    [self setItem:item atIndex:_currentItemIndex];
    //  Go to the next item
    _currentItemIndex++;
    //  Loop it around (if we are on the last item
    _currentItemIndex %= NUMBER_OF_ITEMS;
    [[_itemViews objectAtIndex:_currentItemIndex] setIsCurrentItem:YES];
}

-(void)setItem:(RICItem *)item atIndex:(NSUInteger)index {
    [_items replaceObjectAtIndex:index withObject:item];
    [[_itemViews objectAtIndex:index] setItem:item];
}

-(IBAction)championPortraitClicked:(id)sender {
    [_selectionController showChampions];
}

-(IBAction)importWindowsBuildCode:(id)sender {
    NSArray *items = [RICRecommendedItemManager itemsFromWindowsBuildCode:[sender stringValue]];
    for(NSUInteger i = 0 ; i < [items count] ; i++) {
        [self setItem:[items objectAtIndex:i] atIndex:i];
    }
}

- (void)dealloc
{
    [super dealloc];
}

@end