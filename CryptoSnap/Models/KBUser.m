//
//  KBUser.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/25/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

//"id":               "55c079bf5f1650fc1361a1c3a4709900",
//"basics":           { },
//"invitation_stats": { },
//"profile":          null,
//"emails":           { },
//"public_keys":      { },
//"private_keys":     { }

#import "KBUser.h"

@implementation KBUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @
    {
        @"ID": @"id",
        @"invitationStats" : @"invitation_stats",
        @"publicKeys" : @"public_keys",
        @"privateKeys" : @"private_keys"
    };
}

@end
