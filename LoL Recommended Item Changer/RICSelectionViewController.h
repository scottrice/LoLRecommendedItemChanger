//
//  RICSelectionViewController.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/23/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RICConstants.h"
#import "RICDatabaseManager.h"
#import "RICSelectionItemView.h"
#import "RICCurrentSelectionViewController.h"

@protocol RICSelectionDelegate

-(void)selectChampion:(RICChampion *)champion;
-(void)selectItem:(RICItem *)item;

@end

@interface RICSelectionViewController : NSViewController <RICSelectionDelegate,NSCollectionViewDelegate>{
@private
    IBOutlet NSScrollView *_championScrollView;
    IBOutlet NSScrollView *_itemScrollView;
    IBOutlet NSCollectionView *_championCollection;
    IBOutlet NSCollectionView *_itemCollection;
    
    RICCurrentSelectionViewController *_currentSelection;
}

-(void)selectChampion:(RICChampion *)champion;
-(void)selectItem:(RICItem *)item;

-(void)showChampions;
-(void)showItems;

@property(nonatomic,retain)RICCurrentSelectionViewController *currentSelectionController;

@end
