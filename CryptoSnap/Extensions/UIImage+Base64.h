//
//  UIImage+Base64.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Base64)

- (NSString *)base64String;

+ (UIImage *)imageFromBase64EncodedString:(NSString *)string;

@end
