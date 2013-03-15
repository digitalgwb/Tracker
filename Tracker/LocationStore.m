//
//  LocationStore.m
//  Tracker
//
//  Created by Gary Black on 3/6/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "LocationStore.h"
#import "Location.h"

@implementation LocationStore

+ (LocationStore *)sharedStore
{
    static LocationStore *sharedStore = nil;
    
    if (!sharedStore)
    {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        locations = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)locations
{
    return locations;
}

- (Location *)createLocation
{
    Location *p = [[Location alloc] init];
    [p setCategory:@"Category"];
    [p setName:@"Name"];
    CLLocation *point = [[CLLocation alloc] init];
    [p setPoint:point];
    
    [locations addObject:p];
    
    return p;
}


@end
