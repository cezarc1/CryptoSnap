//
//  CSEncryption.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 3/31/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSEncryption : NSObject


/**
 Calculates hmac_pwh according to Keybase.io's documentation.
 https://keybase.io/__/api-docs/1.0#call-login
 
 @param passphraseString the user's password
 @param saltString string provided by getsalt endpoint
 @param loginSession string provided by getsalt endpoint
 */
+ (NSString *)HMACforPassphrase:(NSString *)passphraseString
                     saltString:(NSString *)saltString
               andLogginSession:(NSString *)loginSession;

@end
