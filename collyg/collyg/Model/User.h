//
//  User.h
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import <Parse/Parse.h>
#import "Location.h"
#import "Team.h"

@interface User : PFUser<PFSubclassing>
@property (nonatomic, strong) NSString *mobilephone;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) Team *team;
@property (nonatomic, strong) NSString *profilePicture;
@property (nonatomic, strong) NSString *displayName;
@end
