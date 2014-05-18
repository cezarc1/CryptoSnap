//
//  KBUserTableViewCell.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/27/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "KBUserTableViewCell.h"
#import "KBUser.h"
#import "KBUserBasics.h"
#import "KBUserProfile.h"

@implementation KBUserTableViewCell

- (void)configureCellForUser:(KBUser *)user
{
    self.userNameLabel.text = user.basics.username;
    self.bioLabel.text = user.profile.bio;
    self.fullNameLabel.text = user.profile.fullName;
}

@end
