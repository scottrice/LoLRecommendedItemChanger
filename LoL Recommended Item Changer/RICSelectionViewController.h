//
//  RICSelectionViewController.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/23/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RICDatabaseManager.h"

@interface RICSelectionViewController : NSViewController {
@private
    IBOutlet NSCollectionView *_collection;
}

-(void)setChampion:(RICChampion *)champion;
-(void)setNextItem:(RICItem *)item;

@end
