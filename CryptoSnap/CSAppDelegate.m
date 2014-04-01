//
//  CSAppDelegate.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 3/30/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "CSAppDelegate.h"
#import "crypto_scrypt.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>



@implementation CSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
