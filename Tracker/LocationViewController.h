//
//  LocationViewController.h
//  Tracker
//
//  Created by Gary Black on 3/4/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "AbstractTrackerViewController.h"
#import "TrackerLocationViewDelegate.h"

@interface LocationViewController : AbstractTrackerViewController {
    BOOL viewWasCancelled;  // YES if the user canclled from the view, NO otherwise
}

@property (weak, nonatomic) id <TrackerLocationViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *locationName;
@property (weak, nonatomic) IBOutlet UITextField *locationCategory;

@end
