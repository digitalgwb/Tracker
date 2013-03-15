//
//  TrackerStore.h
//  Tracker
//
//  Created by Gary Black on 3/12/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Settings;

@interface TrackerStore : NSObject
{
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+ (TrackerStore *)sharedStore;

- (double)getOdometer;
- (void)setOdometer:(double)odometer;
- (Settings*)getSettings;
- (void)update;

@end
