//
//  RICSelectionItemView.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 4/9/12.
//  Copyright 2012 Midnight Drive Applications. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RICConstants.h"

#import "RICChampion.h"
#import "RICItem.h"

@class RICCollectionViewItem;

@interface RICSelectionItemView : NSView {
@private
    RICCollectionViewItem *_collectionItem;
    
    BOOL _aRealDrag;
}

-(void)setIsDrag;

@property(nonatomic,retain)RICCollectionViewItem *collectionItem;

@end
