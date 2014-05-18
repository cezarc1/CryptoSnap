//
//  KBPublicKey.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/26/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBPublicKey.h"

@implementation KBPublicKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:super.JSONKeyPathsByPropertyKey];
    [dict addEntriesFromDictionary:@{@"keyFingerprint": @"key_fingerprint"}];
    return dict;
}

@end
