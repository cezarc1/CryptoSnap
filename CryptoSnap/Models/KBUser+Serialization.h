//
//  KBUser+Serialization.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/25/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBUser.h"

@interface KBUser (Serialization)

+ (KBUser *)userFromDictionary:(NSDictionary *)dict;

@end
