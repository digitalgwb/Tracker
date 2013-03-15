//
//  LocationTableViewController.m
//  Tracker
//
//  Created by Gary Black on 3/6/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "LocationTableViewController.h"
#import "LocationStore.h"
#import "LocationCell.h"
#import "Location.h"

@implementation LocationTableViewController

- (id)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        UINavigationItem *n = [self navigationItem];
        
        // Add a title "Tracks"
        [n setTitle:@"Locations"];
        
        for (int i = 0; i < 5; i++)
        {
            [[LocationStore sharedStore] createLocation];
        }
        
        [[self view] setBackgroundColor:[UIColor whiteColor]];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"LocationCell" bundle:nil];
    
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"LocationCell"];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[LocationStore sharedStore] locations] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Location *p = [[[LocationStore sharedStore] locations] objectAtIndex:[indexPath row]];
    
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    
    [[cell name] setText:[p name]];
    [[cell category] setText:[p category]];
    
    return cell;
}

@end
