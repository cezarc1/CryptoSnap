//
//  UIImage+Resize.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

//http://stackoverflow.com/questions/7645454/resize-uiimage-by-keeping-aspect-ratio-and-width
+ (UIImage *)imageWithImage:(UIImage *)sourceImage scaledToMaxWidth:(float)i_width
{
    float oldWidth = sourceImage.size.width;
    if (oldWidth < i_width) {
        return sourceImage;
    }
    
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
