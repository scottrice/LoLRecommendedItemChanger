//
//  RICCurrentSelectionViewController.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/21/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICCurrentSelectionViewController.h"

#define X_MARGIN 10
#define Y_VALUE_OF_FIRST_ITEM_VIEW 550

@implementation RICCurrentSelectionViewController

@synthesize championIconView=_championIconView,selectionViewController=_selectionController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"RICCurrentSelectionView" bundle:nibBundleOrNil];
    if (self) {
        _items = [NSMutableArray arrayWithCapacity:NUMBER_OF_ITEMS];
        _itemViews = [NSMutableArray arrayWithCapacity:NUMBER_OF_ITEMS];
        NSUInteger currentY = Y_VALUE_OF_FIRST_ITEM_VIEW;
        //  Create all the item views
        for(NSInteger i = 0 ; i < NUMBER_OF_ITEMS ; i++) {
            //  At least Apple learned with iOS, but the current nib loading interface is NOT a good one
            //  Anyway, load the nib and have the new view set as the _loadedCurrentItemView object
            [NSBundle loadNibNamed:@"RICSelectedItemView" owner:self];
            [_loadedCurrentItemView setFrameOrigin:CGPointMake(X_MARGIN, currentY)];
            [[self view] addSubview:_loadedCurrentItemView];
            [_itemViews addObject:_loadedCurrentItemView];
            //  Set currentY to the correct value for the next iteration
            currentY -= [_loadedCurrentItemView frame].size.height;
        }
        [_championIconView setTarget:self];
        [_championIconView setAction:@selector(championPortraitClicked:)];
        
    }
    
    return self;
}

-(void)setChampion:(RICChampion *)champion {
    [_championIconView setImage:[champion icon]];
    [_championLabel setStringValue:[champion name]];
}

-(void)setNextItem:(RICItem *)item {
    [self setItem:item atIndex:_currentItemIndex];
    //  Go to the next item
    _currentItemIndex++;
    //  Loop it around (if we are on the last item
    _currentItemIndex %= NUMBER_OF_ITEMS;
}

-(void)setItem:(RICItem *)item atIndex:(NSUInteger)index {
//    [_items replaceObjectAtIndex:index withObject:item];
//    [[_itemViews objectAtIndex:index] setItem:item];
}

-(IBAction)championPortraitClicked:(id)sender {
    [_selectionController showChampions];
}

- (void)dealloc
{
    [super dealloc];
}

@end