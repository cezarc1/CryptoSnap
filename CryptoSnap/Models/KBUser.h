//
//  KBUser.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/25/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//


#import "MTLModel.h"
#import "Mantle/Mantle.h"

@class KBUserBasics;
@class KBPublicKeys;
@class KBPrivateKeys;
@class KBUserProfile;

@interface KBUser : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *ID;

@property (strong, nonatomic) KBUserBasics *basics;

@property (strong, nonatomic) NSDictionary *invitationStats;

@property (strong, nonatomic) KBUserProfile *profile;

@property (strong, nonatomic) NSDictionary *emails;

@property (strong, nonatomic) KBPublicKeys *publicKeys;

@property (strong, nonatomic) KBPrivateKeys *privateKeys;

@end
