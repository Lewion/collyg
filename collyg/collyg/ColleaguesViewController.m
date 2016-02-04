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
@property (nonatomic, strong) NSArray *availableColleagues;
@property (nonatomic, strong) NSArray *unavailableColleagues;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) User *selectedUser;
@end

@implementation ColleaguesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.availableColleagues = [NSArray new];
    self.unavailableColleagues = [NSArray new];
    [self setupLogoutButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUsers) name:@"UPDATEVIEW" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUsers {
    [[Service sharedManager] fetchAllUsersWithSuccess:^(NSArray *availableUsers, NSArray *unavailableUsers) {
        self.availableColleagues = availableUsers;
        self.unavailableColleagues = unavailableUsers;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [super showAlertWithError:error];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = true;
    self.navigationController.navigationBarHidden = false;
    self.title = @"Collyg";
    [self updateUsers];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.availableColleagues.count;
    }
    return self.unavailableColleagues.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColleagueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColleagueCell"];

    User *user;
    if (indexPath.section == 0) {
        user = self.availableColleagues[indexPath.row];
    } else {
        user = self.unavailableColleagues[indexPath.row];
    }
    cell.displayName.text = user.displayName;
    cell.location.text = user.location.location;
    cell.teamLabel.text = user.team.teamName;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://collyg.be/profiles/small_%@", user.profilePicture]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [cell.colleagueProfileImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.colleagueProfileImageView.image = image;
        [self createMaskForImage:cell.colleagueProfileImageView];
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        cell.colleagueProfileImageView.image = [UIImage imageNamed:@"default_profile_image"];
        [self createMaskForImage:cell.colleagueProfileImageView];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:false];
}

-(void)createMaskForImage:(UIImageView *)image
{
    CALayer *mask = [CALayer layer];
    UIImage *maskImage = [UIImage imageNamed:@"circle.png"];
    mask.contents = (id)[maskImage CGImage];
    mask.frame = CGRectMake(0, 0, image.frame.size.width, image.frame.size.height);
    image.layer.mask = mask;
    image.layer.masksToBounds = YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    User *user;
    if (path.section == 0) {
        user = self.availableColleagues[path.row];
    } else {
        user = self.unavailableColleagues[path.row];
    }
    ColleagueDetailViewController *detail = segue.destinationViewController;
    detail.user = user;
}

@end
