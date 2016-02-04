//
//  Location.m
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import "Location.h"

@implementation Location
@dynamic address;
@dynamic latitude;
@dynamic longitude;
@dynamic location;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Location";
}

@end
