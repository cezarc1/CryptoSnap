//
//  CSPhotoTableViewCell.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "CSPhotoTableViewCell.h"
#import <Parse/Parse.h>
#import "UIImage+Base64.h"
#import "DateTools.h"

@implementation CSPhotoTableViewCell

- (void)configureForPFObject:(PFObject *) image
{
    PFUser *fromUser =  image[@"from"];
    [fromUser fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            self.fromLabel.text = fromUser.username;
        }
    }];
    NSString *base64EncodedImage = image[@"photoData"];
    
    //Would decrypt and verify here
    self.imageReceived.image = [UIImage imageFromBase64EncodedString:base64EncodedImage];
    self.sentTimeLabel.text = image.createdAt.timeAgoSinceNow;
}

@end
