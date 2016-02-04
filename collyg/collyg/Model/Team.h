//
//  Team.h
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import <Parse/Parse.h>

@interface Team : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property (nonatomic, strong) NSString *teamName;
@end
