//
//  KBUserProfile.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "Mantle/Mantle.h"

@interface KBUserProfile : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *fullName;

@property (strong, nonatomic) NSString *location;

@property (strong, nonatomic) NSString *bio;

@property (strong, nonatomic) NSNumber *mtime;

@end
