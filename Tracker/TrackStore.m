//
//  TrackStore.m
//  Tracker
//
//  Created by sasgwb on 3/6/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "TrackStore.h"
#import "Track.h"

@implementation TrackStore

+ (TrackStore *)sharedStore
{
    static TrackStore *sharedStore = nil;
    
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
        tracks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)tracks
{
    return tracks;
}

- (Track *)createTrack
{
    Track *p = [[Track alloc] init];
    [p setFromLocation:@"Origin"];
    [p setToLocation:@"Destination"];
    
    [tracks addObject:p];
    
    return p;
}
@end
