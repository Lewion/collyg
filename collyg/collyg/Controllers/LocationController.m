//
//  LocationController.m
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import "LocationController.h"
#import "Service.h"
#import "Location.h"
#import <Parse/Parse.h>

@interface LocationController ()
@property (nonatomic, strong) NSArray *knownLocations;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation LocationController

#pragma mark Singleton Methods

+ (id)sharedManager {
    static LocationController *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)updateKnownLocations {
    [[Service sharedManager] fetchAllLocationsWithSuccess:^(NSArray *locations) {
        self.knownLocations = locations;
    } failure:^(NSError *error) {
        
    }];
}

- (void)startLocationUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestAlwaysAuthorization];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.activityType = CLActivityTypeFitness;
    
    // Movement threshold for new events.
    self.locationManager.distanceFilter = 10; // meters
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *newLocation in locations) {
        if (newLocation.horizontalAccuracy < 50) {
            User *user = [User currentUser];
            Location *newUserLocation = [self locationIfInKnownRegion:newLocation];
            if (newUserLocation != nil) {
                user.location = newUserLocation;
            }
            
            [[Service sharedManager] updateUser:user];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(locationUpdated:)]) {
                [self.delegate locationUpdated:newLocation];
            }
        }
    }
}

- (Location*)locationIfInKnownRegion:(CLLocation*)location {
    
    Location *locationToReturn = nil;
    
    for (Location *loc in self.knownLocations) {
        CLLocationDistance distanceFromLoc = [location distanceFromLocation:[loc parseLocationToUsableLocation]];
        if (distanceFromLoc > 0 && distanceFromLoc < 1000) {
            locationToReturn = loc;
        }
    }
    
    return locationToReturn;
}

@end
