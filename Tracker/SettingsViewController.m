//
//  SettingsViewController.m
//  Tracker
//
//  Created by sasgwb on 3/5/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "SettingsViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationTableViewController.h"
#import "TrackerStore.h"
#import "Settings.h"

@implementation SettingsViewController

@synthesize delegate;
@synthesize odometerDisplay;
@synthesize distanceToleranceDisplay;
@synthesize speedToleranceDisplay;
@synthesize accuracyBar;
/*
 * Initialize this view from the SettingsViewController.xib
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UINavigationItem *n = [self navigationItem];
        
        // Add a title "Settings" and a "Cancel" button to the navigation bar
        [n setTitle:@"Settings"];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                      target:self
                                      action:@selector(cancel:)];
        [n setRightBarButtonItem:cancelBtn];
        viewWasCancelled = NO;
    }
    
    return self;
    
}

- (void)viewDidLoad
{
    Settings* settings = [[TrackerStore sharedStore] getSettings];
    double distance = [settings distanceTolerance] * 3.28084;
    double speed = [settings speedTolerance] * 3.28084;
    
    [distanceToleranceDisplay setText:[NSString stringWithFormat:@"%5.1f", distance]];
    [speedToleranceDisplay setText:[NSString stringWithFormat:@"%5.1f", speed]];
    [odometerDisplay setText:[NSString stringWithFormat:@"%07.1f", [settings odometer]]];
}

/*
 * The user ended the view.
 */
- (void)viewWillDisappear:(BOOL)animated
{
    // If the user did NOT select "Cancel", do this
    if (viewWasCancelled == NO) {
        CLLocationAccuracy arrAccuracy[4] = { kCLLocationAccuracyBestForNavigation,
                                                kCLLocationAccuracyBest,
                                                kCLLocationAccuracyNearestTenMeters,
                                                kCLLocationAccuracyHundredMeters };
            
        double odometer = [[odometerDisplay text] doubleValue];
        double distance = [[distanceToleranceDisplay text] doubleValue];
        // Convert feet to meters
        distance = distance / 3.28084;
        double speed = [[speedToleranceDisplay text] doubleValue];
        // Convert feet/sec to meters/sec
        speed = speed / 3.28084;
        int selectedAccuracy = [accuracyBar selectedSegmentIndex];
            
        Settings* settings = [[TrackerStore sharedStore] getSettings];
        [settings setOdometer:odometer];
        [settings setDistanceTolerance:distance];
        [settings setSpeedTolerance:speed];
        [[TrackerStore sharedStore] update];
            
        [[self delegate] settingsDidChange];
    }
}

/*
 * The user selected "Cancel"
 */
- (void)cancel:(id)sender
{
    viewWasCancelled = YES;
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)editLocations:(id)sender {
    LocationTableViewController *ltvc = [[LocationTableViewController alloc] init];
    [[self navigationController] pushViewController:ltvc animated:YES];
}

@end
