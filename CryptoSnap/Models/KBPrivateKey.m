//
//  KBKey.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/26/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBPrivateKey.h"

@implementation KBPrivateKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"keyType": @"key_type"};
}

@end
