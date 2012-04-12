//
//  RICCurrentSelectionViewController.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/21/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RICConstants.h"

#import "RICItem.h"
#import "RICChampion.h"

#import "RICCurrentlySelectedItemView.h"

@class RICSelectionViewController;

@interface RICCurrentSelectionViewController : NSViewController {
@private
    //  Selection
    RICChampion *_champion;
    IBOutlet NSButton *_championIconView;
    IBOutlet NSTextField *_championLabel;
    
    NSMutableArray *_items;
    NSMutableArray *_itemViews;
    
    NSUInteger _currentItemIndex;
    
    RICSelectionViewController *_selectionController;
    
    //  Used in the nib
    IBOutlet RICCurrentlySelectedItemView *_loadedCurrentItemView;
}


-(void)setChampion:(RICChampion *)champion;
-(void)setNextItem:(RICItem *)item;
-(void)setItem:(RICItem *)item atIndex:(NSUInteger)index;

-(IBAction)championPortraitClicked:(id)sender;

@property(nonatomic,retain)NSButton *championIconView;
@property(nonatomic,retain)RICSelectionViewController *selectionViewController;

@end