//
//  KBUser+Requests.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBUser+Requests.h"
#import "KBAPIClient.h"
#import "KBUserBasics.h"
#import "UIImage+Base64.h"
#import "UIImage+Resize.h"
#import <Parse/Parse.h>

@implementation KBUser (Requests)

+ (void)searchForUsersWithName:(NSString *)name
                   withSuccess:(void (^)(NSArray *users))success
                   andFailiure:(void (^)(NSError *err))failiure
{
    [[KBAPIClient sharedClient] GET:@"user/lookup.json"
                         parameters:@{@"username": name}
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                NSDictionary *response = responseObject;
                                
                                //Right now the API only returns one user at a time, this may change
                                NSDictionary *them = response[@"them"];
                                
                                NSMutableArray *kbUsers = [NSMutableArray array];
                                KBUser *thisUser = nil;
                                NSError *modelingError;
                                thisUser = [MTLJSONAdapter modelOfClass:[KBUser class]
                                                     fromJSONDictionary:them
                                                                  error:&modelingError];
                                if (!modelingError) {
                                    [kbUsers addObject:thisUser];
                                }
                                
                                success(kbUsers);
                                
                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                NSLog(@"Search For Users ERROR: %@", error);
                                failiure(error);
                            }];
}

- (void)sendImage:(UIImage *)image
{
    if (image != nil) {
        PFObject *photoObject = [PFObject objectWithClassName:@"Photo"];
        UIImage *resizedImage = [UIImage imageWithImage:image scaledToMaxWidth:200.0f];
        
        //Would encrypt and sign here
        photoObject[@"photoData"] = resizedImage.base64String;
        photoObject[@"from"] = [PFUser currentUser];
        photoObject[@"to"] = self.basics.username;
        
        PFACL *photoACL = [PFACL ACLWithUser:[PFUser currentUser]];
        [photoACL setPublicReadAccess:YES];
        [photoACL setPublicWriteAccess:NO];
        photoObject.ACL = photoACL;
        
        [photoObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"Error in saving photo: %@", error);
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PhotoPostedToParse" object:nil];
            }
        }];
    } else {
        NSLog(@"Trying to send null image");
    }

}

@end
