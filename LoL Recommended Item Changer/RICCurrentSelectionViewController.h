//
//  RICCurrentSelectionViewController.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/21/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RICChampion.h"
#import "RICItem.h"

@interface RICCurrentSelectionViewController : NSViewController {
@private
    //  Selection
    RICChampion *_champion;
    NSImageView *_championView;
    
    NSArray *_items;
    NSImageView *_item1Label;
    NSImageView *_item2Label;
    NSImageView *_item3Label;
    NSImageView *_item4Label;
    NSImageView *_item5Label;
    NSImageView *_item6Label;
    NSImageView *_item1Icon;
    NSImageView *_item2Icon;
    NSImageView *_item3Icon;
    NSImageView *_item4Icon;
    NSImageView *_item5Icon;
    NSImageView *_item6Icon;
}


-(void)setChampion:(RICChampion *)champion;
-(void)setItem:(RICItem *)item atIndex:(NSInteger)index;

//  Lookin at this makes me feel like I'm doing it wrong. 
//  I would imagine the correct way to do this is to make
//  the item icon/label in a seperate nib then link up those
//  to instance variables. 
//
//  Unfortunately I am too unfamiliar with OS X development to
//  do this. So for now:
//  TODO: Remake the variable scheme using a more intelligant desin
@property(nonatomic,retain)IBOutlet NSImageView *championView;
@property(nonatomic,retain)IBOutlet NSImageView *item1Label;
@property(nonatomic,retain)IBOutlet NSImageView *item2Label;
@property(nonatomic,retain)IBOutlet NSImageView *item3Label;
@property(nonatomic,retain)IBOutlet NSImageView *item4Label;
@property(nonatomic,retain)IBOutlet NSImageView *item5Label;
@property(nonatomic,retain)IBOutlet NSImageView *item6Label;
@property(nonatomic,retain)IBOutlet NSImageView *item1Icon;
@property(nonatomic,retain)IBOutlet NSImageView *item2Icon;
@property(nonatomic,retain)IBOutlet NSImageView *item3Icon;
@property(nonatomic,retain)IBOutlet NSImageView *item4Icon;
@property(nonatomic,retain)IBOutlet NSImageView *item5Icon;
@property(nonatomic,retain)IBOutlet NSImageView *item6Icon;

@end