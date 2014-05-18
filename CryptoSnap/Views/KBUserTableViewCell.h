//
//  KBUserTableViewCell.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/27/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KBUser;

@interface KBUserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photo;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *bioLabel;

- (void)configureCellForUser:(KBUser *)user;

@end
