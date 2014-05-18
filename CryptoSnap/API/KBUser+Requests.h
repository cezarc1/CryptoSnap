//
//  KBUser+Requests.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBUser.h"

@interface KBUser (Requests)

+ (void)searchForUsersWithName:(NSString *)name
                   withSuccess:(void (^)(NSArray *users))success
                   andFailiure:(void (^)(NSError *err))failiure;

- (void)sendImage:(UIImage *)image;
@end
