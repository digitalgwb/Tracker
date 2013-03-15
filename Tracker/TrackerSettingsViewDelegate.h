//
//  TrackerSettingsViewDelegate.h
//  Tracker
//
//  Created by sasgwb on 3/5/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol TrackerSettingsViewDelegate <NSObject>
@optional
- (void)settingsDidChange;
@end
