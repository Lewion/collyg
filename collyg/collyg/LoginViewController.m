//
//  ViewController.m
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import "LoginViewController.h"
#import "Service.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.loginButton.layer.cornerRadius = 8.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
    [self checkLoggedIn];
}

- (void)checkLoggedIn {
    if ([User currentUser] != nil) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
}

- (IBAction)loginButtonTapped:(id)sender {
    [[Service sharedManager] loginWithUserName:self.usernameTextField.text password:self.passwordTextField.text success:^(User *user) {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    } failure:^(NSError *error) {
        [super showAlertWithError:error];
    }];
}

@end