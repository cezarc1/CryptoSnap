//
//  KBPublicKey.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/26/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "Mantle/Mantle.h"
@class KBPublicKey;

@interface KBPublicKeys : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) KBPublicKey *primary;

@end
