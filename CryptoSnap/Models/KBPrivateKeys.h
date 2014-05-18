//
//  KBPrivateKeys.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/26/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "Mantle/Mantle.h"
@class KBPrivateKey;

@interface KBPrivateKeys : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) KBPrivateKey *primary;

@end
