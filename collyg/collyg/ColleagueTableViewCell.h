//
//  ColleagueTableViewCell.h
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColleagueTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *colleagueProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *location;
@end
