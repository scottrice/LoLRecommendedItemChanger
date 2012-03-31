//
//  RICDatabaseManager.m
//  LoL Recommended Item Changer
//
//  Created by Scott on 12/13/11.
//  Copyright 2011 Midnight Drive Applications. All rights reserved.
//

#import "RICDatabaseManager.h"

NSString *RICLOLDatabaseLocation()
{
    return [[NSBundle mainBundle] pathForResource:@"LoLData" ofType:@"sqlite"];
}

static int sqlite_callback(void *object, int argc, char **argv, char **azColName) {
	RICDatabaseManager *_man = (RICDatabaseManager *)object;
	if ([_man tempDict] == nil) {
		[_man setTempDict:[NSMutableDictionary dictionaryWithCapacity:1]];
		for (NSInteger i = 0; i < argc; i++) {
			NSMutableArray *_currArr = [NSMutableArray arrayWithCapacity:1];
			[[_man tempDict] setObject:_currArr forKey:[NSString stringWithUTF8String:azColName[i]]];
		}
	}
	for (NSInteger i = 0; i < argc; i++) {
		[[[_man tempDict] objectForKey:[NSString stringWithUTF8String:azColName[i]]] addObject:[NSString stringWithUTF8String:argv[i]]];
	}
	return SQLITE_OK;
}

@interface RICDatabaseManager (Private)

-(NSDictionary *)executeQuery:(NSString *)query;
-(RICChampion *)championFromResultsDictionary:(NSDictionary *)dictionary atIndex:(NSInteger)index;
-(RICItem *)itemFromResultsDictionary:(NSDictionary *)dictionary atIndex:(NSInteger)index;

@end

@implementation RICDatabaseManager

@synthesize tempDict;

+(id)defaultManager
{
    static RICDatabaseManager *__shared = nil;
    return ((__shared) ? __shared : (__shared = [[RICDatabaseManager alloc] init]));
}

- (id)init
{
    self = [super init];
    if (self) {
        BOOL failed = sqlite3_open([RICLOLDatabaseLocation() UTF8String], &_db);
		if (failed) {
			//	Error Handling
			return nil;
		}
    }
    
    return self;
}

-(NSArray *)allChampions
{
    //  I am going to cheat a little bit. I know how many champions there are.
    //  I mean, capacity doesn't really matter, as it resizes automatically,
    //  but I figure since I CAN give it a good capacity at the start, I will.
    //  In the future though, we will have more champions, and I would like this code
    //  to stil work even though we don't know exactly how many, but at the time of writing
    //  there are 89 champions, but we will do 100 so the capacity is right for a decent amount
    //  of time
    NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:100];
    NSDictionary *results = [self executeQuery:@"SELECT * FROM Champions"];
    for(NSInteger i = 0 ; i < [[results objectForKey:@"nameCode"] count] ; i++)
    {
        [ret addObject:[self championFromResultsDictionary:results atIndex:i]];
    }
    return ret;
}

-(RICChampion *)championWithNameCode:(NSString *)nameCode
{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Champions WHERE nameCode = '%@'",nameCode];
    return [self championFromResultsDictionary:[self executeQuery:query] atIndex:0];
}

-(NSArray *)allItems
{
    //  Items are in a similar situation to champions (see above), so I will just
    //  make the capacity a bit larger than the current number of items
    //  (As a note, there are 115 items as of time of writing)
    NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:130];
    NSDictionary *results = [self executeQuery:@"SELECT * FROM Items"];
    for(NSInteger i = 0 ; i < [[results objectForKey:@"code"] count] ; i++)
    {
        [ret addObject:[self itemFromResultsDictionary:results atIndex:i]];
    }
    return ret;
}

-(RICItem *)itemWithCode:(NSInteger)code
{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM Items WHERE code = %i",code];
    return [self itemFromResultsDictionary:[self executeQuery:query] atIndex:0];
}

-(NSDictionary *)executeQuery:(NSString *)query
{
    NSMutableDictionary *_dict = nil;
	tempDict = nil;
	sqlite3_exec(_db, [query UTF8String], sqlite_callback, self, nil);
	_dict = [[tempDict retain] autorelease];
	[self setTempDict:nil];
	return _dict;
}

-(RICChampion *)championFromResultsDictionary:(NSDictionary *)dictionary atIndex:(NSInteger)index
{
    RICChampion *champ = [RICChampion new];
    [champ setName:[[dictionary objectForKey:@"name"] objectAtIndex:index]];
    [champ setChampionDescription:[[dictionary objectForKey:@"description"] objectAtIndex:index]];
    [champ setNameCode:[[dictionary objectForKey:@"nameCode"] objectAtIndex:index]];
    [champ autorelease];
    return champ;
}

-(RICItem *)itemFromResultsDictionary:(NSDictionary *)dictionary atIndex:(NSInteger)index
{
    RICItem *item = [RICItem new];
    [item setName:[[dictionary objectForKey:@"name"] objectAtIndex:index]];
    [item setCode:[[[dictionary objectForKey:@"code"] objectAtIndex:index] intValue]];
    [item autorelease];
    return item;
}

- (void)dealloc
{
    [super dealloc];
}

@end
