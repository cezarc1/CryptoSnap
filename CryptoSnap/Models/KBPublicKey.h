//
//  KBPublicKey.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/26/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBPrivateKey.h"

@interface KBPublicKey : KBPrivateKey

@property (strong, nonatomic) NSString *ukbid;

@property (strong, nonatomic) NSString *keyFingerprint;

@end
