//
//  Settings.h
//  Tracker
//
//  Created by Gary Black on 3/12/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Settings : NSManagedObject

@property double odometer;
@property double distanceTolerance;
@property double speedTolerance;

@end
