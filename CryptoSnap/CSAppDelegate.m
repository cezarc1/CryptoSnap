//
//  CSAppDelegate.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 3/30/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "CSAppDelegate.h"
#import "CSAPIConstants.h"
#import <Parse/Parse.h>

@implementation CSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:kParseAppId
                  clientKey:kParseAppSecret];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [self setDefaultParseSecurityPolicy];
    
    return YES;
}

- (void)setDefaultParseSecurityPolicy
{
    [PFUser enableAutomaticUser];
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [defaultACL setPublicWriteAccess:NO];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
}


@end
