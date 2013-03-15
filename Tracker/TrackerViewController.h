//
//  TrackerViewController.h
//  Tracker
//
//  Created by Gary Black on 3/4/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TrackerLocationViewDelegate.h"
#import "TrackerSettingsViewDelegate.h"
#import "TrackerLocationManagerDelegate.h"

@interface TrackerViewController : UIViewController <UIPickerViewDataSource,
                                                     UIPickerViewDelegate,
                                                     UIActionSheetDelegate,
                                                     TrackerLocationViewDelegate,
                                                     TrackerSettingsViewDelegate,
                                                     TrackerLocationManagerDelegate>
{
    NSMutableArray *arrOdometer;  // Array used to hold odometer adjustment values
    UIActionSheet *actionSheet;   // Action sheet to hold the odometer adjustment picker
    UIPickerView *odometerPicker; // Odometer adjustment picker

    double distanceTolerance;
    double speedTolerance;
}

@property (weak, nonatomic) IBOutlet UILabel *odometerDisplay;
@property (weak, nonatomic) IBOutlet UILabel *location;

- (IBAction)editSettings:(id)sender;
- (IBAction)tracks:(id)sender;
- (IBAction)adjustOdometer:(id)sender;
- (IBAction)adjustLocation:(id)sender;
- (IBAction)startTracking:(id)sender;
- (IBAction)stopTracking:(id)sender;

@end
