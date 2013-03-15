//
//  TrackStore.h
//  Tracker
//
//  Created by sasgwb on 3/6/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Track;

@interface TrackStore : NSObject
{
    NSMutableArray *tracks;
}

+ (TrackStore *)sharedStore;

- (NSArray *)tracks;
- (Track *)createTrack;

@end
