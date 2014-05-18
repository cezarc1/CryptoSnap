//
//  LoginViewController.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/25/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "LoginViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <NSHash/NSString+NSHash.h>
#import <NSHash/NSData+NSHash.h>
#import "KBAPIClient.h"
#import "CSEncryption.h"
#import "KBUser.h"
#import "KBPublicKeys.h"
#import "KBPublicKey.h"
#import "KBPrivateKeys.h"
#import "KBPrivateKey.h"
#import "KBUserBasics.h"
#import "OpenPGP.h"
#import "SVProgressHUD.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property KBUser *currentKBUser;

@end

@implementation LoginViewController


- (void)viewWillAppear:(BOOL)animated
{
    [PFUser logOut];
    [super viewWillAppear:animated];
    
    [self.userNameField becomeFirstResponder];
}

- (IBAction)loginPressed:(UIButton *)sender
{
    [self.view resignFirstResponder];
    [SVProgressHUD showWithStatus:@"Logging into KeybBase"];
    
    KBAPIClient *client = [KBAPIClient sharedClient];
    [client getSaltForUser:self.userNameField.text
                WithSucess:^(NSString *salt, NSString *csrfToken, NSString *loginSession) {
                    [self computePWHFor:salt
                                  token:csrfToken
                                session:loginSession];
                } andFailiure:^(NSError *error) {
                    [SVProgressHUD dismiss];
                    NSLog(@"%@",error);
                }];
}

- (void)computePWHFor:(NSString *)salt
                token:(NSString *)token
              session:(NSString *)session
{
    [SVProgressHUD showWithStatus:@"Computing PWH"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *pwh = [CSEncryption HMACforPassphrase:self.passwordField.text
                                             saltString:salt
                                       andLogginSession:session];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showWithStatus:@"Logging into Keybase"];
            [[KBAPIClient sharedClient] loginForUser:self.userNameField.text
                                              andPwh:pwh
                                        loginSession:session
                                          WithSucess:^(KBUser *user) {
                                              [self didLoginToKBUsingUser:user];
                                              
                                          } andFailiure:^(NSError *error) {
                                              [SVProgressHUD dismiss];
                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error singing into Keybase"
                                                                                              message:[error localizedDescription]
                                                                                             delegate: nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil];
                                              [alert show];
                                          }];
        });
    });

}

- (void)didLoginToKBUsingUser:(KBUser *)kbUser
{

    [SVProgressHUD showWithStatus:@"Logging into Parse"];
    self.currentKBUser = kbUser;
    // show the signup or login screen
    if ([LoginViewController doesUserExistForKBUser:kbUser]) {
        [PFUser logInWithUsernameInBackground:kbUser.basics.username password:[self passwordForUser:kbUser]
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [self loginWasSuccesfull];
                                            } else {
                                                [SVProgressHUD dismiss];
                                                NSString *errorString = [error userInfo][@"error"];
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error singing into Parse"
                                                                                                message: errorString
                                                                                               delegate: nil
                                                                                      cancelButtonTitle:@"OK"
                                                                                      otherButtonTitles:nil];
                                                [alert show];
                                            }
                                        }];
    } else {//sign up
        [self signUpToParseUsingKBUser:kbUser];
    }
}

+ (BOOL)doesUserExistForKBUser:(KBUser *)kbUser
{
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:kbUser.basics.username];
    return (BOOL)[query getFirstObject];
}

- (void)signUpToParseUsingKBUser:(KBUser *)kbUser
{
    PFUser *pfUser = [PFUser user];
    pfUser.username = kbUser.basics.username;
    pfUser.password = [self passwordForUser:kbUser];
    
    pfUser[@"public_key"] = kbUser.publicKeys.primary.bundle;
    
    [pfUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self loginWasSuccesfull];
        } else {
            [SVProgressHUD dismiss];
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error singing into Parse"
                                                            message: errorString
                                                           delegate: nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (NSString *)passwordForUser:(KBUser *)user
{
    NSString *passwordString = [NSString stringWithFormat:@"%@%@", self.passwordField.text, user.privateKeys.primary.bundle];
    return passwordString.SHA256;
}

- (void)loginWasSuccesfull
{
    [SVProgressHUD showSuccessWithStatus:@"Logged into Parse"];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        
        [self performSegueWithIdentifier:@"loginSucessfullSegue" sender:nil];
    }];
}

@end
