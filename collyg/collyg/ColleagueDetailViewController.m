//
//  ColleagueDetailViewController.m
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import "ColleagueDetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ColleagueDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellphoneButton;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;

@end

@implementation ColleagueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.displayName.text = self.user.displayName;
    self.locationLabel.text = (self.user.location != nil) ? self.user.location.location : @"Location not known";
    [self.cellphoneButton setTitle:self.user.mobilephone forState:UIControlStateNormal];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://collyg.be/profiles/%@", self.user.profilePicture]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [self.profileImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.profileImageView .image = image;
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        self.profileImageView.image = [UIImage imageNamed:@"default_profile_image"];
    }];
}

- (IBAction)cellphoneButtonTapped:(id)sender {
    NSURL *cellUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[self.user.mobilephone stringByReplacingOccurrencesOfString:@" " withString:@""]]];
    
    if ([[UIApplication sharedApplication]canOpenURL:cellUrl]) {
        [[UIApplication sharedApplication] openURL:cellUrl];
    }
}

@end
