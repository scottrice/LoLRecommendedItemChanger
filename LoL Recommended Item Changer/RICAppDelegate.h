//
//  LoL_Recommended_Item_ChangerAppDelegate.h
//  LoL Recommended Item Changer
//
//  Created by Scott on 11/6/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RICINIManager.h"
#import "RICDatabaseManager.h"
#import "RICRecommendedItemManager.h"
#import "RICSelectionViewController.h"
#import "RICCurrentSelectionViewController.h"

@interface RICAppDelegate : NSObject <NSApplicationDelegate> {
@private
    IBOutlet NSWindow *_window;
    RICSelectionViewController *_selection;
    RICCurrentSelectionViewController *_currentSelection;
}

-(IBAction)chooseAppFile:(id)sender;
-(IBAction)deploy:(id)sender;

@property (assign) NSWindow *window;

@end