//
//  OpenPGP.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/4/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenPGP : NSObject <UIWebViewDelegate>

+ (NSString *)encryptMessage:(NSString *)message
                      forKey:(NSString *)key;

+ (NSString *)encryptMessageAndSign:(NSString *)message
                       forPublicKey:(NSString *)pubKey
                      andPrivateKey:(NSString *)pvtKey;

+ (NSString *)decryptMessageAndVerify:(NSString *)message
                         forPublicKey:(NSString *)pubKey
                        andPrivateKey:(NSString *)pvtKey;

+ (NSString *)decryptMessage:(NSString *)message
                      forKey:(NSString *)key;
@end
