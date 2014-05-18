//
//  CSPhotoTableViewCell.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFObject;

@interface CSPhotoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageReceived;

@property (weak, nonatomic) IBOutlet UILabel *fromLabel;

@property (weak, nonatomic) IBOutlet UILabel *sentTimeLabel;

- (void)configureForPFObject:(PFObject *) image;

@end
