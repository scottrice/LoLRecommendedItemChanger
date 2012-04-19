//
//  RICRecommendedItemManager.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 11/8/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICRecommendedItemManager.h"

#define LOLAPPFILEPATHDEFAULTSKEY @"LoLAppFilePath"

@interface RICRecommendedItemManager (Private)

- (NSString *)championDirectory;
- (BOOL)championDirectoryExists;
- (NSString *)iniPath;
- (void)setChampion:(RICChampion *)champion;
- (NSArray *)readItemsFromExistingINI;

@end

@implementation RICRecommendedItemManager

#pragma mark -
#pragma mark Class Methods

+(NSString *)LOLAppFilePath
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:LOLAPPFILEPATHDEFAULTSKEY];
}

+(void)setLOLAppFilePath:(NSString *)path
{
    NSString *storedPath = [[NSUserDefaults standardUserDefaults] stringForKey:LOLAPPFILEPATHDEFAULTSKEY];
    if(storedPath != path)
        [[NSUserDefaults standardUserDefaults] setObject:path forKey:LOLAPPFILEPATHDEFAULTSKEY];
}

+(BOOL)setRecommendedItems:(NSArray *)items forChampion:(RICChampion *)champion
{
    RICRecommendedItemManager *manager = [[RICRecommendedItemManager alloc] initWithChampion:champion];
    return [manager setItems:items];
}

+(NSArray *)itemsFromWindowsBuildCode:(NSString *)buildCode {
    //  Each item should be referenced by a 4 digit item id.
    if([buildCode length] != (NUMBER_OF_ITEMS * LENGTH_OF_ITEM_CODE))
        return nil;
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:NUMBER_OF_ITEMS];
    NSRange range = NSMakeRange(0, LENGTH_OF_ITEM_CODE);
    for(NSUInteger i = 0 ; i < NUMBER_OF_ITEMS ; i++) {
        range.location = i * LENGTH_OF_ITEM_CODE;
        NSInteger itemCode = [[buildCode substringWithRange:range] intValue];
        RICItem *item = [RICItem findItemWithCode:itemCode];
        [ret addObject:item];
    }
    return ret;
}

+(NSString *)windowsBuildCodeFromItems:(NSArray *)items {
    if([items count] != NUMBER_OF_ITEMS)
        return nil;
    NSMutableString *buildCode = [[NSMutableString alloc] initWithCapacity:NUMBER_OF_ITEMS * LENGTH_OF_ITEM_CODE];
    for(NSUInteger i = 0 ; i < NUMBER_OF_ITEMS ; i++) {
        [buildCode appendString:[[items objectAtIndex:i] codeString]];
    }
    return [NSString stringWithString:buildCode];
}

#pragma mark -
#pragma mark Instance Methods

-(id)initWithChampion:(RICChampion *)champion
{
    self = [super init];
    if(self)
    {
        [self setChampion:champion];
    }
    return self;
}

-(id)init {
    if([super init])
    {
        NSLog(@"Please do not use -init on RICRecommendedItemManager. Use -initWithChampion instead"); 
    }
    return self;
}

-(BOOL)isUsingCustomItems
{
    //  If the INI file exists, then we know they are using custom recommended items
    return [[NSFileManager defaultManager] fileExistsAtPath:[self iniPath]];
}

-(NSArray *)items
{
    if(!_items && [self isUsingCustomItems])
        _items = [self readItemsFromExistingINI];
    return _items;
}

-(BOOL)setItems:(NSArray *)items
{
    NSError *error = nil;
    NSString *iniString = [RICINIManager generateINIStringForItemCodes:items];
    if(![self championDirectoryExists])
        [[NSFileManager defaultManager] createDirectoryAtPath:[self championDirectory] withIntermediateDirectories:YES attributes:nil error:nil];
    [iniString writeToFile:[self iniPath] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(error == nil)
    {
        _items = items;
        return YES;
    }
    NSLog(@"%@",error);
    return NO;   
}

-(BOOL)clearRecommendedItems
{
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:[self iniPath] error:nil];
    if(success)
        _items = nil;
    return success;
}

#pragma mark -
#pragma mark Private

- (NSString *)championDirectory
{
    if(!_championDirectory)
    {
        //  TODO: Actually detect whether they are using iLoL or the old Boompje version
        BOOL iLoL = YES;
        if(!iLoL) {
            //  This data was good for old versions of Boompje LoL. iLoL uses a completely different setup
            NSString *base = [[RICRecommendedItemManager LOLAppFilePath] stringByAppendingString:@"/Contents/Resources/transgaming/c_drive/rads/solutions/lol_game_client_sln/releases"];
            //  Now that we have the base, we need to get the version number folder.
            //  According to the wiki, this folder name will change with updates, but
            //  there will still only be one folder. In that case, we will just get the
            //  contents of the directoy, then grab the last (only) object
            NSError *error;
            NSString *release = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:base error:&error] lastObject];
            _championDirectory = [NSString stringWithFormat:@"%@/%@/deploy/DATA/Characters/%@",base,release,[_champion nameCode]];
        }
        else {
            //  For iLoL, things are MUCH simpler
            NSString *charactersDirectory = [[RICRecommendedItemManager LOLAppFilePath] stringByAppendingString:@"/Contents/Resources/League of Legends/files/DATA/Characters"];
            _championDirectory = [charactersDirectory stringByAppendingPathComponent:[_champion nameCode]];
        }
    }
    return _championDirectory;
}

- (BOOL)championDirectoryExists
{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self championDirectory]];
}

-(NSString *)iniPath
{
    return [[self championDirectory] stringByAppendingPathComponent:@"RecItemsCLASSIC.ini"];
}

-(void)setChampion:(RICChampion *)champion
{
    _champion = champion;
    _championDirectory = nil;
}

-(NSArray *)readItemsFromExistingINI
{
    if ([self isUsingCustomItems]) {
        NSString *iniString = [NSString stringWithContentsOfFile:[self iniPath] encoding:NSUTF8StringEncoding error:nil];
        return [RICINIManager readItemsFromINIString:iniString];
    }
    return nil;
}

-(void)dealloc
{
    [super dealloc];
}

@end
