//
//  TrackerStore.m
//  Tracker
//
//  Created by Gary Black on 3/12/13.
//  Copyright (c) 2013 Parkmeadow Productions. All rights reserved.
//

#import "TrackerStore.h"
#import "Settings.h"

@implementation TrackerStore

+ (TrackerStore *)sharedStore
{
    static TrackerStore *sharedStore = nil;
    if (!sharedStore)
    {
        sharedStore = [[TrackerStore alloc] init];
    }
    
    return sharedStore;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        NSError *error = nil;
        NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *dbPath = [directory stringByAppendingPathComponent:@"store.data"];
        NSURL *dbURL = [NSURL fileURLWithPath:dbPath];
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:dbURL
                                     options:nil
                                       error:&error])
        {
            [NSException raise:@"Open failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        [context setUndoManager:nil];
    }
    
    return self;
}

- (double)getOdometer
{
    Settings* settings = [self fetchSettings];
    return [settings odometer];
}

- (void)setOdometer:(double)odometer
{
    Settings *settings = [self fetchSettings];
    [settings setOdometer:odometer];
    
    [context save:nil];
}

- (Settings*)getSettings
{
    return [self fetchSettings];
}

- (void)update
{
    [context save:nil];
}

- (Settings*)fetchSettings
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Settings" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"odometer" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    Settings *settings = nil;
    
    if ([result count] == 0)
    {
        settings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:context];
    }
    else
    {
        settings = [result objectAtIndex:0];
    }
    
    return settings;
}

- (void)persistSettings:(Settings*)settings
{
    NSError *error;
    [context save:&error];
}




@end
