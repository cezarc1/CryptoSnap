//
//  CSMainTabBarController.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "CSMainTabBarController.h"
#import "Parse/Parse.h"

@interface CSMainTabBarController ()

@end

@implementation CSMainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidPostPhoto)
                                                 name:@"userDidPostImage"
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)userDidPostPhoto
{
    self.selectedIndex = 0;
}
- (IBAction)logOut:(UIButton *)sender
{
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
