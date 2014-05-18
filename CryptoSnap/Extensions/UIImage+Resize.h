//
//  UIImage+Resize.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

+ (UIImage *)imageWithImage:(UIImage *)sourceImage scaledToMaxWidth:(float)i_width;

@end
