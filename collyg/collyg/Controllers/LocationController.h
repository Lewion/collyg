//
//  LocationController.h
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol LocationControllerDelegate <NSObject>
- (void)locationUpdated:(CLLocation *)location;
@end

@interface LocationController : NSObject <CLLocationManagerDelegate>
+ (id)sharedManager;
- (void)updateKnownLocations;
- (void)startLocationUpdates;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, weak) id <LocationControllerDelegate> delegate;
@end
