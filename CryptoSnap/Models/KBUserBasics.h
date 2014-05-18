//
//  KBUserBasics.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/26/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

//"uid":      "55c079bf5f1650fc1361a1c3a4709900",
//"salt":     "533a6842479b5e925856d1ce2a444...",
//"username": "chris",
//"ctime":    1383161061,
//"mtime":    1383161061,

#import "Mantle/Mantle.h"

@interface KBUserBasics : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *uid;

@property (strong, nonatomic) NSString *salt;

@property (strong, nonatomic) NSString *username;

@property (strong, nonatomic) NSNumber *trackVersion;

@property (strong, nonatomic) NSNumber *ctime;

@property (strong, nonatomic) NSNumber *mtime;

@end
