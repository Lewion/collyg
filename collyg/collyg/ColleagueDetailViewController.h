//
//  ColleagueDetailViewController.h
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "User.h"

@interface ColleagueDetailViewController : UIViewController
@property (nonatomic, strong) User* user;
@end
