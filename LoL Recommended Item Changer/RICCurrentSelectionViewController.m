//
//  RICCurrentSelectionViewController.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/21/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICCurrentSelectionViewController.h"

@implementation RICCurrentSelectionViewController

@synthesize championView=_championView,
            item1Label=_item1Label,
            item2Label=_item2Label,
            item3Label=_item3Label,
            item4Label=_item4Label,
            item5Label=_item5Label,
            item6Label=_item6Label,
            item1Icon=_item1Icon,
            item2Icon=_item2Icon,
            item3Icon=_item3Icon,
            item4Icon=_item4Icon,
            item5Icon=_item5Icon,
            item6Icon=_item6Icon;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"RICCurrentSelectionView" bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end