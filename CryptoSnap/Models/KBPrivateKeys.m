//
//  KBPrivateKeys.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/26/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBPrivateKeys.h"
#import "KBPrivateKey.h"

@implementation KBPrivateKeys

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"primary": @"primary"};
}

+ (NSValueTransformer *)primaryJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[KBPrivateKey class]];
}

@end
