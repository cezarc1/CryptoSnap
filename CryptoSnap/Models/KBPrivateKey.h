//
//  KBKey.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/26/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//


#import "Mantle/Mantle.h"

@interface KBPrivateKey : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *bundle;

@property (strong, nonatomic) NSString *kid;

@property (strong, nonatomic) NSNumber *ctime;

@property (strong, nonatomic) NSNumber *mtime;

@property (strong, nonatomic) NSNumber *keyType;

@end
