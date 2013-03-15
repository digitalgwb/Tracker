//
//  SettingsViewController.h
//  Tracker
//
//  Created by sasgwb on 3/5/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractTrackerViewController.h"
#import "TrackerSettingsViewDelegate.h"

@interface SettingsViewController : AbstractTrackerViewController
{
    BOOL viewWasCancelled;  // YES if the user cancelled the view, NO otherwise
}

@property (weak, nonatomic) id <TrackerSettingsViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *odometerDisplay;
@property (weak, nonatomic) IBOutlet UITextField *distanceToleranceDisplay;
@property (weak, nonatomic) IBOutlet UITextField *speedToleranceDisplay;
@property (weak, nonatomic) IBOutlet UISegmentedControl *accuracyBar;

- (IBAction)editLocations:(id)sender;

@end
