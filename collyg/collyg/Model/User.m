//
//  User.m
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import "User.h"

@implementation User
@dynamic mobilephone;
@dynamic location;
@dynamic team;
@dynamic profilePicture;
@dynamic displayName;

+ (void)load {
    [self registerSubclass];
}

@end
