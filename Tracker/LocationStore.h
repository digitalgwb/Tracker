//
//  LocationStore.h
//  Tracker
//
//  Created by Gary Black on 3/6/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@interface LocationStore : NSObject
{
    NSMutableArray *locations;
}

+ (LocationStore*)sharedStore;

- (NSArray*)locations;
- (Location*)createLocation;

@end
