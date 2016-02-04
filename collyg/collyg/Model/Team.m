//
//  Team.m
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import "Team.h"

@implementation Team
@dynamic teamName;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Team";
}

@end
