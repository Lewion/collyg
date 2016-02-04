//
//  Service.h
//  collyg
//
//  Created by Nikki Vergracht on 04/02/16.
//  Copyright © 2016 Mediahuis. All rights reserved.
//

#import <Parse/Parse.h>
#import "User.h"

typedef void (^loginCompletionBlock)(User*);
typedef void (^usersCompletionBlock)(NSArray*);
typedef void (^locationsCompletionBlock)(NSArray*);
typedef void (^errorBlock)(NSError*);


@interface Service : NSObject
+ (id)sharedManager;
- (void) loginWithUserName:(NSString *)userName password:(NSString *)password success:(loginCompletionBlock)successBlock failure:(errorBlock)failureBlock;
- (void) fetchAllUsersWithSuccess:(usersCompletionBlock)successBlock failure:(errorBlock)failureBlock;
@end
