//
//  TrackerViewController.m
//  Tracker
//
//  Created by Gary Black on 3/4/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "TrackerViewController.h"
#import "LocationViewController.h"
#import "SettingsViewController.h"
#import "TrackTableViewController.h"
#import "LocationManager.h"
#import "TrackerStore.h"
#import "Settings.h"

@implementation TrackerViewController

@synthesize odometer;
@synthesize odometerDisplay;
@synthesize location;
/*
 * Initialize this view with TrackerViewController.xib
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        // Add two buttons to the Navigation Bar: Logs and Settings
        UINavigationItem *n = [self navigationItem];
        
        [n setTitle:@"Tracker"];
        
        UIBarButtonItem *editBtn = [[UIBarButtonItem alloc]
                                initWithTitle:@"Settings"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(editSettings:)];
        UIBarButtonItem *logsBtn = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Tracks"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(tracks:)];
        [n setRightBarButtonItem:editBtn];
        [n setLeftBarButtonItem:logsBtn];
    }
    
    return self;
}

/*
 * The view loaded - initalize the odometer value
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Settings* settings = [[TrackerStore sharedStore] getSettings];
    
    [self setOdometerValue:[settings odometer]];
    distanceTolerance = [settings distanceTolerance];
    speedTolerance = [settings speedTolerance];
    
}

/*
 * Set the odometer value
 */
- (void)setOdometerValue:(double)value
{
    // Initialize the number
    odometer = value;
    
    // Initialize the control
    [odometerDisplay setText:[NSString stringWithFormat:@"%08.1f", odometer]];
}

/*
 * Start tracking
 */
- (IBAction)startTracking:(id)sender
{
    [[LocationManager instance] setDelegate:self];
    [[LocationManager instance] setOdometer:odometer];
    [[LocationManager instance] start];
}

/*
 * Stop tracking
 */
- (IBAction)stopTracking:(id)sender
{
    [[LocationManager instance] stop];
    [[LocationManager instance] setDelegate:nil];
}

- (void)odometerDidChange:(double)newOdometer
{
    [self setOdometerValue:newOdometer];
}

- (double)getDistanceTolerance
{
    return distanceTolerance;
}

- (double)getSpeedTolerance
{
    return speedTolerance;
}

/*
 * Invoke the Settings panel
 */
- (IBAction)editSettings:(id)sender
{
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    [svc setDelegate:self];
    [[self navigationController] pushViewController:svc animated:YES];
}

- (void)settingsDidChange
{
    Settings* settings = [[TrackerStore sharedStore] getSettings];
    [self setOdometerValue:[settings odometer]];
    [[LocationManager instance] settingsDidChange];
    
    NSLog(@"Changed settings");
}

/*
 * Invoke the Logs panel
 */
- (IBAction)tracks:(id)sender
{
    TrackTableViewController *ttvc = [[TrackTableViewController alloc] init];
    [[self navigationController] pushViewController:ttvc animated:YES];
}

/*
 * Invoke the Location Adjustment panel
 */
- (IBAction)adjustLocation:(id)sender
{
    LocationViewController *lvc = [[LocationViewController alloc] init];
    [lvc setDelegate:self];
    [[self navigationController] pushViewController:lvc animated:YES];
}

- (void)setLocationName:(NSString *)locationName withCategory:(NSString *)category
{
    NSLog(@"Setting location name: %@", locationName);
    NSLog(@"Setting location category: %@", category);
    
    [location setText:locationName];
}

//=====================================================================
// Odometer adjustment action sheet / picker
//=====================================================================

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arrOdometer.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arrOdometer objectAtIndex:row];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == UIBarButtonSystemItemDone)
    {
        [self setOdometerValue: [[arrOdometer objectAtIndex:[odometerPicker selectedRowInComponent:0]] doubleValue]];
    }
}

- (IBAction)adjustOdometer:(id)sender
{
    arrOdometer = [[NSMutableArray alloc] init];
    
    for (int i = odometer-10; i < odometer+200; i++)
    {
        [arrOdometer addObject:[NSString stringWithFormat:@"%7d", i]];
    }
    
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"Adjust Odometer"
                                              delegate:self
                                     cancelButtonTitle:nil
                                destructiveButtonTitle:nil
                                     otherButtonTitles:nil];
    
    odometerPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    [odometerPicker setShowsSelectionIndicator:YES];
    [odometerPicker setDataSource:self];
    [odometerPicker setDelegate:self];
    [odometerPicker selectRow:10 inComponent:0 animated:YES];
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *cancelBtn =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                      target:self
                                                      action:@selector(PickerCancelled:)];
    UIBarButtonItem *title =
        [[UIBarButtonItem alloc] initWithTitle:@"Adjust Odometer"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:nil];
    UIBarButtonItem *doneBtn =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                      target:self
                                                      action:@selector(PickerDone:)];
    
    [barItems addObject:doneBtn];
    [barItems addObject:title];
    [barItems addObject:cancelBtn];
    
    [pickerToolbar setItems:barItems animated:YES];
    
    [actionSheet addSubview:pickerToolbar];
    [actionSheet addSubview:odometerPicker];
    [actionSheet showInView:self.view];
    [actionSheet setBounds:CGRectMake(0, 0, 320, 464)];
                                  
    
}

- (void)PickerCancelled:(id)sender
{
    [actionSheet dismissWithClickedButtonIndex:UIBarButtonSystemItemCancel animated:YES];
}

- (void)PickerDone:(id)sender
{
    [actionSheet dismissWithClickedButtonIndex:UIBarButtonSystemItemDone animated:YES];
}
@end
