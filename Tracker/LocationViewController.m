//
//  LocationViewController.m
//  Tracker
//
//  Created by Gary Black on 3/4/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "LocationViewController.h"

@implementation LocationViewController

@synthesize delegate;
@synthesize locationName;
@synthesize locationCategory;

/*
 * Initialize this controller with the LocationViewController.xib
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UINavigationItem *n = [self navigationItem];
        
        // Add a title "Location" and a cancel button to the navigation bar
        [n setTitle:@"Location"];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                           target:self
                                                           action:@selector(cancel:)];
        [n setRightBarButtonItem:cancelBtn];
        viewWasCancelled = NO;
    }
    
    return self;

}

/*
 * User has ended the view.
 */
- (void)viewWillDisappear:(BOOL)animated
{
    // If the user did NOT select "Cancel" do this
    if (viewWasCancelled == NO) {
        // Update the name/category of the current location
        if ([delegate respondsToSelector:@selector(setLocationName:withCategory:)]) {
            [delegate setLocationName:[locationName text] withCategory:[locationCategory text]];
        }
    }
}

/*
 * The user selected the "Cancel" button
 */
- (void)cancel:(id)sender
{
    viewWasCancelled = YES;
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
