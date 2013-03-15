//
//  TrackerLocationViewDelegate.h
//  Tracker
//
//  Created by sasgwb on 3/5/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TrackerLocationViewDelegate <NSObject>
@optional
- (void)setLocationName:(NSString *)locationName withCategory:(NSString *)category;
@end
