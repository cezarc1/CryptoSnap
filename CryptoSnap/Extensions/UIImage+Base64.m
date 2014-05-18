//
//  UIImage+Base64.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "UIImage+Base64.h"
#import "NSData+Base64.h"

@implementation UIImage (Base64)

- (NSString *)base64String
{
    return [UIImageJPEGRepresentation(self, 0.6) base64EncodedString];
}

+ (UIImage *)imageFromBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData dataFromBase64String:string];
    return [UIImage imageWithData:data];
}

@end
