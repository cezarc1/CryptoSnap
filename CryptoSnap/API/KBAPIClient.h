//
//  KBAPIClient.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/25/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@class KBUser;

@interface KBAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)getSaltForUser:(NSString *)user
                              WithSucess:(void (^)(NSString *salt, NSString* csrfToken, NSString *loginSession))success
                             andFailiure:(void (^)(NSError *error))failiure;

- (NSURLSessionDataTask *)loginForUser:(NSString *)user
                                andPwh:(NSString *)pwh
                          loginSession:(NSString *)loginSession
                            WithSucess:(void (^)(KBUser *user))success
                           andFailiure:(void (^)(NSError *error))failiure;

@end
