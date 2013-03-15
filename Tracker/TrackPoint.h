//
//  TrackPoint.h
//  Tracker
//
//  Created by sasgwb on 3/14/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//
// A Point on a Track
//
// Based on the GPX schema type wptType, using only these fields from the schema
// <... lat="number between -90.0 and 90.0" lon="number between -180.0 and 180.0">
//    ---- All of the following are optional ----
//    <ele>decimal</ele>     Elevation (in meters) of the point
//    <time>dateTime</time>  Creation/modification timestamp in UTC
//    <magvar>number between 0.0 and 360.0</magvar>   Magnetic variation (in degrees) at the point
// </...>
@interface TrackPoint : NSObject
// Elevation: Obtained from CLLocation.altitude (in meters)
// Time: Obtained from CLLocation.timestamp
// Magvar: Obtained from CLLocation.course

@property CLLocation* point;

@end
