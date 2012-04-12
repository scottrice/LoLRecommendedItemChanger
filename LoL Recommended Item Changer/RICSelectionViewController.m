//
//  RICSelectionViewController.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/23/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICSelectionViewController.h"

@interface RICSelectionViewController (Private)

-(void)viewDidFinishInitialization;

@end

@implementation RICSelectionViewController

@synthesize currentSelectionController=_currentSelection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"RICSelectionView" bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)selectChampion:(RICChampion *)champion {
    [_currentSelection setChampion:champion];
    [self showItems];
}

-(void)selectItem:(RICItem *)item {
    [_currentSelection setNextItem:item];
}

-(void)showChampions {
    [_championScrollView setHidden:NO];
    [_itemScrollView setHidden:YES];
}

-(void)showItems {
    [_championScrollView setHidden:YES];
    [_itemScrollView setHidden:NO];
}

#pragma mark -
#pragma mark Dragging and Dropping

-(BOOL)collectionView:(NSCollectionView *)collectionView canDragItemsAtIndexes:(NSIndexSet *)indexes withEvent:(NSEvent*)event {
    [(RICSelectionItemView *)[[collectionView itemAtIndex:[indexes lastIndex]] view] setIsDrag];
    return YES;
}

- (BOOL)collectionView:(NSCollectionView *)collectionView writeItemsAtIndexes:(NSIndexSet *)indexes toPasteboard:(NSPasteboard *)pasteboard {
    RICItem *item = [[collectionView content] objectAtIndex:[indexes lastIndex]];
    [pasteboard clearContents];
    [pasteboard declareTypes:[NSArray arrayWithObject:RICITEMDRAGTYPE] owner:self];
    [pasteboard setString:[item codeString] forType:RICITEMDRAGTYPE];
    return YES;
}

- (NSImage *)collectionView:(NSCollectionView *)collectionView draggingImageForItemsAtIndexes:(NSIndexSet *)indexes withEvent:(NSEvent *)event offset:(NSPointPointer)dragImageOffset {
    RICItem *item = [[collectionView content] objectAtIndex:[indexes lastIndex]];
    return [item icon];
}

#pragma mark -
#pragma mark Private

-(void)viewDidFinishInitialization
{
    [_championCollection setSelectable:YES];
    [_championCollection setContent:[[RICDatabaseManager defaultManager] allChampions]];
    [_itemCollection setSelectable:YES];
    [_itemCollection setContent:[[RICDatabaseManager defaultManager] allItems]];
    [_itemCollection setDelegate:self];
    [self selectChampion:[RICChampion findChampionWithNameCode:@"Ashe"]];
}

-(void)loadView
{
    [super loadView];
    //  Unlike iOS, Mac OS X has no viewDidLoad method, and in fact
    //  the docs recommend using the strategy below (overriding loadView
    //  and adding our custom logic method in wherever we need) to achieve
    //  this functionality. A quick note on the naming though. Originally, I
    //  was going to name viewDidFinishInitialization as viewDidLoad to be
    //  similar to it's iOS counterpart. Given how Apple is moving OS X to be
    //  more like iOS though, it is very possible that they will add an official
    //  viewDidLoad to OS X in future versions. Given that, my code then would
    //  have called viewDidLoad twice: once in the super call to loadView, and once
    //  in the current call. Given that, I have decided to name my method
    //  viewDidFinishInitialization instead.
    [self viewDidFinishInitialization];
}

- (void)dealloc
{
    [super dealloc];
}

@end
