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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"RICSelectionView" bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)setChampion:(RICChampion *)champion
{
    
}

-(void)setNextItem:(RICItem *)item
{
    
}

#pragma mark -
#pragma mark Private

-(void)viewDidFinishInitialization
{
    [_collection setContent:[[RICDatabaseManager defaultManager] allChampions]];
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
