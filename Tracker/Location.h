//
//  Location.h
//  Tracker
//
//  Created by Gary Black on 3/6/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//
// A User-defined location
//
// Based on the GPX schema type wptType, using only these fields from the schema
//    <name>string</name>  GPS name of the point
//    <cmt>string</cmt>    GPS waypoint comment
//    <desc>string</desc>  Text description of the point
//    <src>string</src>    Source of the data
//    <sym>string</sym>    Text of GPS symbol name
//    <type>string></sym>  type (classification) of the waypoint
// </...>
@interface Location : NSObject
// TrackPoint: The point at which this location exists
//
// Name: Obtained from user, or from CLGeocoder
// Cmt: Obtained from user
// Src: "iPhone"
// Sym: Obtained from user
// Type: Obtained from user

@property (weak, nonatomic) CLLocation* point;
@property (weak, atomic) NSString* name;
@property (weak, atomic) NSString* category;

@end
