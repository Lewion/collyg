//
//  ColleaguesViewController.m
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import "ColleaguesViewController.h"
#import <Parse/Parse.h>
#import "ColleagueTableViewCell.h"
#import "Service.h"
#import "ColleagueDetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ColleaguesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *colleagues;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) User *selectedUser;
@end

@implementation ColleaguesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.colleagues = [NSArray new];
    [self setupLogoutButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBarHidden = false;
    self.title = @"Collyg";
    [[Service sharedManager] fetchAllUsersWithSuccess:^(NSArray *users) {
        self.colleagues = users;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [super showAlertWithError:error];
    }];
}

- (void)setupLogoutButton {
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logoutCurrentUser)];
    self.navigationItem.rightBarButtonItem = logoutButton;
}

- (void)logoutCurrentUser {
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - TableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colleagues.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColleagueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColleagueCell"];
    User *user = self.colleagues[indexPath.row];
    cell.displayName.text = user.displayName;
    cell.location.text = user.location.location;
    cell.teamLabel.text = user.team.teamName;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://collyg.be/profiles/small_%@", user.profilePicture]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [cell.colleagueProfileImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.colleagueProfileImageView.image = image;
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        cell.colleagueProfileImageView.image = [UIImage imageNamed:@"default_profile_image"];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedUser = self.colleagues[indexPath.row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    User *user = self.colleagues[path.row];
    ColleagueDetailViewController *detail = segue.destinationViewController;
    detail.user = user;
}

@end
