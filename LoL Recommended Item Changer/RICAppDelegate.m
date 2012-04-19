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
    _currentSelection = [[RICCurrentSelectionViewController alloc] initWithNibName:nil bundle:nil];
    _selection = [[RICSelectionViewController alloc] initWithNibName:nil bundle:nil];
    [_selection setCurrentSelectionController:_currentSelection];
    [_currentSelection setSelectionViewController:_selection];
    
    CGRect wf = [[_window contentView] frame];
    CGRect csf = [[_currentSelection view] frame];
    
    //  Load the current selection view
//    [[_currentSelection view] setFrameOrigin:CGPointMake(0, wh - csh)];
    [[_window contentView] addSubview:[_currentSelection view]];
    
    //  Load the view to select champions/items
    [[_selection view] setFrame:CGRectMake(csf.size.width, 0, wf.size.width-csf.size.width, wf.size.height)];
    [[_window contentView] addSubview:[_selection view]];
}

-(IBAction)deploy:(id)sender {
    RICChampion *champion = [_currentSelection champion];
    NSArray *items = [_currentSelection items];
    NSLog(@"Setting items %@ for %@",items, champion);
    NSLog(@"%@",[RICRecommendedItemManager LOLAppFilePath]);
}

-(IBAction)chooseAppFile:(id)sender {
    NSOpenPanel *openPanel = [[NSOpenPanel openPanel] retain];
    [openPanel setDirectoryURL:[NSURL fileURLWithPath:@"/Applications/" isDirectory:YES]];
    [openPanel setAllowedFileTypes:[NSArray arrayWithObject:@"app"]];
    [openPanel beginWithCompletionHandler:^(NSInteger result){
        [RICRecommendedItemManager setLOLAppFilePath:[[[openPanel URLs] objectAtIndex:0] path]];
    }];
}

@end