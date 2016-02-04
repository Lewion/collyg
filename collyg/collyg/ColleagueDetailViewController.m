//
//  ColleagueDetailViewController.m
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import "ColleagueDetailViewController.h"

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
    [self.cellphoneButton setTitle:self.user.telephone forState:UIControlStateNormal];
}

- (IBAction)cellphoneButtonTapped:(id)sender {
    NSURL *cellUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[self.user objectForKey:@"telephone"]]];
    
    if ([[UIApplication sharedApplication]canOpenURL:cellUrl]) {
        [[UIApplication sharedApplication] openURL:cellUrl];
    }
}

@end
