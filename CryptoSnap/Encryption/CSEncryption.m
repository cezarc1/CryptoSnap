//
//  CSEncryption.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 3/31/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "CSEncryption.h"

#import "crypto_scrypt.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

#import "KBUser.h"
#import "KBPublicKeys.h"
#import "KBPublicKey.h"
#import "KBUserBasics.h"

#define kCSScryptN pow(2,15)
#define kCSScryptR 8
#define kCSScryptP 1
#define kCSBufferLength 224
#define kCSBufferOffset 192


@implementation CSEncryption

//http://stackoverflow.com/q/22766016/2127731
+ (NSString *)HMACforPassphrase:(NSString *)passphraseString
                     saltString:(NSString *)saltString
               andLogginSession:(NSString *)loginSession
{
    uint8_t *passphrase = (uint8_t *)[passphraseString dataUsingEncoding:NSASCIIStringEncoding].bytes;
    NSUInteger passphraseLength = strlen([passphraseString cStringUsingEncoding: NSASCIIStringEncoding]);
    
    uint8_t *salt = (uint8_t *)saltString.decodeFromHexidecimal.bytes;
    NSUInteger saltLength = strlen([saltString cStringUsingEncoding: NSASCIIStringEncoding]) / 2;
    uint8_t buffer[kCSBufferLength];
    
    //pwh = scrypt(passphrase, hex2bin(salt), N=215, r=8, p=1, dkLen=224)[192:224]
    crypto_scrypt(passphrase, passphraseLength, salt, saltLength, kCSScryptN, kCSScryptR, kCSScryptP, buffer, kCSBufferLength);
    uint8_t *pwh = buffer + kCSBufferOffset;
    
    
    NSData *decodedData = [NSData dataFromBase64String:loginSession];
    uint8_t *decodedCString = (uint8_t *)decodedData.bytes;
    unsigned char cHMAC[CC_SHA512_DIGEST_LENGTH];
    
    //hmac_pwh = HMAC-SHA512(pwh, base64decode(login_session))
    CCHmac(kCCHmacAlgSHA512, pwh, kCSBufferLength - kCSBufferOffset, decodedCString, strlen((char *)decodedCString), cHMAC);
    
    NSString *result = hmac(CC_SHA512_DIGEST_LENGTH, cHMAC);
    
    return result;
}

NSString* hmac(unsigned int size, unsigned char cHMAC[size])
{
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < size; i++)
    {
        [result appendFormat:@"%02hhx", cHMAC[i]];
    }
    
    return result;
}

@end
