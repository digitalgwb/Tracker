//
//  LocationManager.m
//  Tracker
//
//  Created by sasgwb on 3/12/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "LocationManager.h"
#import "TrackerStore.h"
#import "Settings.h"

@implementation LocationManager

@synthesize odometer;
@synthesize locationManager;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:self];
        [locationManager setDistanceFilter:kCLDistanceFilterNone];
        [locationManager setHeadingFilter:kCLHeadingFilterNone];
        isMoving = false;
    }
    
    return self;
}

+ (LocationManager*)instance
{
    static LocationManager* instance;
    if (!instance)
    {
        @synchronized(instance)
        {
            instance = [[LocationManager alloc] init];
        }
    }
    
    return instance;
}

- (void)start
{
    lastLocation = nil;
    updateCount = 0;
    Settings* settings = [[TrackerStore sharedStore] getSettings];
    
    odometer = [[self delegate] odometer];
    speedTolerance = [settings speedTolerance];
    distanceTolerance = [settings distanceTolerance];
    
    [locationManager startUpdatingLocation];
}

- (void)stop
{
    [locationManager stopUpdatingLocation];
}

- (void)settingsDidChange
{
    Settings* settings = [[TrackerStore sharedStore] getSettings];
    odometer = [settings odometer];
    distanceTolerance = [settings distanceTolerance];
    speedTolerance = [settings speedTolerance];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // Skip the first 5 seconds of locations after starting to get a stable fix
    if (updateCount < 5)
    {
        updateCount++;
        return;
    }
    
    // Get the most recent location
    CLLocation* mostRecent = [locations lastObject];
    
    isMoving = NO;
    
    // If there was a previous location, compute the distance from that distance (in feet) to this one
    // Otherwise, just set the previous location and return
    if (lastLocation == nil)
    {
        lastLocation = mostRecent;
        return;
    }

    // Get distance, in meters
    CLLocationDistance distance = [mostRecent distanceFromLocation:lastLocation];
    // Get speed, in meters/sec
    CLLocationSpeed speed = [mostRecent speed];
    

    NSLog(@"Speed-Tolerance (%3.1f-%3.1f)  Distance-Tolerance(%3.1f-%3.1f)", speed, speedTolerance, distance, distanceTolerance);
    // If the distance travelled is greater than the distanceTolerance, then we may have moved
    // Check that the speed is above the speed tolerance.  If not, then we probably didn't move
    if ((distance >= distanceTolerance) && (speed >= speedTolerance))
    {
        // We've moved
        isMoving = YES;
        
        // Convert the distance to miles
        distance = (distance * 3.28084)/5280.0;
        
        [self setOdometer:[self odometer] + distance];
        [[self delegate] odometerDidChange:odometer];

        NSLog(@"Moving - Odometer: %08.1f    Speed: %3.0f", odometer, speed);
        lastLocation = mostRecent;
    }
    else
    {
        NSLog(@"Paused");
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"Updating heading");
}

@end
