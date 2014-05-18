//
//  KBUser+Serialization.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/25/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBUser+Serialization.h"
#import "KBUserBasics.h"
#import "KBPublicKeys.h"
#import "KBUserProfile.h"
#import "KBPrivateKeys.h"

@implementation KBUser (Serialization)


+ (KBUser *)userFromDictionary:(NSDictionary *)dict
{
    NSError *err = nil;
    
    KBUser *user = [MTLJSONAdapter modelOfClass:[KBUser class]
                             fromJSONDictionary:dict
                                          error:&err];
    return user;
}

+ (NSValueTransformer *)basicsJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[KBUserBasics class]];
}

+ (NSValueTransformer *)profileJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[KBUserProfile class]];
}

+ (NSValueTransformer *)publicKeysJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[KBPublicKeys class]];
}

+ (NSValueTransformer *)privateKeysJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[KBPrivateKeys class]];
}

@end
