//
//  NSString+Base64.h
//  CryptoSnap
//
//  Created by http://stackoverflow.com/a/2339123/2127731
//
//

#import <Foundation/Foundation.h>

#import <stdio.h>
#import <stdlib.h>
#import <string.h>

@interface NSString (Base64)

- (NSData *) decodeFromHexidecimal;

@end
