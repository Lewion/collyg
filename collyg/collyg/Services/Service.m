//
//  Service.m
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import "Service.h"
#import "User.h"

@interface Service ()

@end

@implementation Service

#pragma mark Singleton Methods

+ (id)sharedManager {
    static Service *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void) loginWithUserName:(NSString *)userName password:(NSString *)password success:(loginCompletionBlock)successBlock failure:(errorBlock)failureBlock {
    [PFUser logInWithUsernameInBackground:userName password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            successBlock((User*)user);
                                        } else {
                                            // The login failed. Check error to see why.
                                            failureBlock(error);
                                        }
                                    }];

}

- (void) fetchAllUsersWithSuccess:(usersCompletionBlock)successBlock failure:(errorBlock)failureBlock {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query includeKey:@"team"];
    [query includeKey:@"location"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            failureBlock(error);
            return;
        }
        
        NSMutableArray *availableUsers = [NSMutableArray new];
        NSMutableArray *unavailableUsers = [NSMutableArray new];
        
        for (User *user in objects) {
            if (user.location) {
                [availableUsers addObject:user];
            } else {
                [unavailableUsers addObject:user];
            }
        }
        
        [availableUsers sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]]];
        [unavailableUsers sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]]];
        
        successBlock(availableUsers, unavailableUsers);
    }];
}

- (void) fetchAllLocationsWithSuccess:(locationsCompletionBlock)successBlock failure:(errorBlock)failureBlock {
    PFQuery *query = [PFQuery queryWithClassName:@"Location"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            failureBlock(error);
            return;
        }
        successBlock(objects);
    }];
}

- (void) updateUser:(User *)user {
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // The currentUser saved successfully.
        } else {
            // There was an error saving the currentUser.
        }
    }];
}

@end
