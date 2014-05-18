//
//  KBAPIClient.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/25/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBAPIClient.h"
#import "KBUser+Serialization.h"

@interface KBAPIClient ()

@property (strong, nonatomic) NSString *secretSessionKey;

@end

@implementation KBAPIClient

+ (instancetype)sharedClient
{
    static KBAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"https://keybase.io/_/api/1.0/"];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"CryptoSnap iOS 1.0"}];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        [config setURLCache:cache];
        
        _sharedClient = [[KBAPIClient alloc] initWithBaseURL:baseURL
                                         sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        //_sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
    });
    
    return _sharedClient;
}


- (NSURLSessionDataTask *)getSaltForUser:(NSString *)user
            WithSucess:(void (^)(NSString *salt, NSString* csrfToken, NSString *loginSession))success
           andFailiure:(void (^)(NSError *error))failiure
{
    return [self GET:@"getsalt.json"
          parameters:@{@"email_or_username": user}
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSString *salt = responseObject[@"salt"];
                 NSString *csrfToken = responseObject[@"csrf_token"];
                 NSString *loginSession = responseObject[@"login_session"];
                 
                 success(salt, csrfToken, loginSession);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 failiure(error);
             }];
}


- (NSURLSessionDataTask *)loginForUser:(NSString *)user
                                andPwh:(NSString *)pwh
                          loginSession:(NSString *)loginSession
                            WithSucess:(void (^)(KBUser *user))success
                           andFailiure:(void (^)(NSError *error))failiure
{
    NSDictionary *dict = @{@"email_or_username": user,
                           @"hmac_pwh": pwh,
                           @"login_session": loginSession};
    
    return [self POST:@"login.json"
           parameters:dict
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  NSString *status = responseObject[@"status"][@"name"];
                  BOOL OK = [status isEqualToString:@"OK"];
                  if (OK) {
                      self.secretSessionKey = responseObject[@"session"];
                      NSDictionary *me = responseObject[@"me"];
                      KBUser *user = [KBUser userFromDictionary:me];
                      
                      success(user);
                  } else {
                      NSError *err = [NSError errorWithDomain:status
                                                         code:422
                                                     userInfo:responseObject];
                      failiure(err);
                  }
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  failiure(error);
              }];
}

@end
