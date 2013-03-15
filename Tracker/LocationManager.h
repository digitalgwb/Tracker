//
//  LocationManager.h
//  Tracker
//
//  Created by sasgwb on 3/12/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "TrackerLocationManagerDelegate.h"

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
    CLLocation* lastLocation;
    int updateCount;
    double speedTolerance;
    double distanceTolerance;
    BOOL isMoving;
}

@property (weak, nonatomic) id <TrackerLocationManagerDelegate> delegate;

@property (strong, nonatomic) CLLocationManager* locationManager;
@property double odometer;


+ (LocationManager*)instance;

- (void)start;
- (void)stop;
- (void)settingsDidChange;

@end
