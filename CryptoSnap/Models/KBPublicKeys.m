//
//  KBPublicKey.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/26/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBPublicKeys.h"
#import "KBPublicKey.h"

@implementation KBPublicKeys

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"primary": @"primary"};
}

+ (NSValueTransformer *)primaryJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[KBPublicKey class]];
}

@end
