//
//  RICCollectionViewItem.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/23/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RICSelectionViewController.h"
#import "RICChampion.h"
#import "RICItem.h"


@interface RICCollectionViewItem : NSCollectionViewItem {
@private
    IBOutlet id<RICSelectionDelegate> _delegate;
    IBOutlet NSTextField *_label;
    IBOutlet NSImageView *_iconView;
}

@property(nonatomic,assign)id<RICSelectionDelegate> delegate;
@property(nonatomic,readonly)NSTextField *label;
@property(nonatomic,readonly)NSImageView *iconView;

@end
