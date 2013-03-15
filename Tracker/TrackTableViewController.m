//
//  TrackTableViewController.m
//  Tracker
//
//  Created by sasgwb on 3/5/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "TrackTableViewController.h"
#import "TrackStore.h"
#import "Track.h"
#import "TrackCell.h"

@implementation TrackTableViewController

- (id)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        UINavigationItem *n = [self navigationItem];
        
        // Add a title "Tracks"
        [n setTitle:@"Tracks"];

        for (int i = 0; i < 5; i++)
        {
            [[TrackStore sharedStore] createTrack];
        }
        
        [[self view] setBackgroundColor:[UIColor whiteColor]];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"TrackCell" bundle:nil];
    
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"TrackCell"];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[TrackStore sharedStore] tracks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Track *p = [[[TrackStore sharedStore] tracks] objectAtIndex:[indexPath row]];
    
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackCell"];
    
    [[cell from] setText:[p fromLocation]];
    [[cell to] setText:[p toLocation]];
    
    return cell;
}
@end
