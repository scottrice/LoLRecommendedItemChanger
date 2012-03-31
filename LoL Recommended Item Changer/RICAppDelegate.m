//
//  LoL_Recommended_Item_ChangerAppDelegate.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 11/6/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICAppDelegate.h"

@implementation RICAppDelegate

@synthesize window=_window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //  Test that the database is working
    NSLog(@"%@",[[[RICDatabaseManager defaultManager] itemWithCode:3001] name]);
    _currentSelection = [[RICCurrentSelectionViewController alloc] initWithNibName:nil bundle:nil];
    _selection = [[RICSelectionViewController alloc] initWithNibName:nil bundle:nil];
    
    CGRect wf = [[_window contentView] frame];
    CGRect csf = [[_currentSelection view] frame];
    
    //  Load the current selection view
//    [[_currentSelection view] setFrameOrigin:CGPointMake(0, wh - csh)];
    [[_window contentView] addSubview:[_currentSelection view]];
    
    //  Load the view to select champions/items
    [[_selection view] setFrame:CGRectMake(csf.size.width, 0, wf.size.width-csf.size.width, wf.size.height)];
    [[_window contentView] addSubview:[_selection view]];
}

@end