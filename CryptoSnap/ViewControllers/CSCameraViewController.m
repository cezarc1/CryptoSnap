//
//  CSCameraViewController.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "CSCameraViewController.h"
#import "CSKBSearchTableViewController.h"

@interface CSCameraViewController ()

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation CSCameraViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userDidPostPhoto)
                                                 name:@"userDidPostImage"
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.imagePicked == nil) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Choose a Image"
                                                           delegate:self
                                                  cancelButtonTitle:@"Nevermind"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"Take a Photo",
                                @"Pick from Camera Roll", nil];
        
        [sheet showInView:self.view];
    }
    

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)userDidPostPhoto
{
    self.imagePicked = nil;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    if (buttonIndex == 0) {// Camera
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else if (buttonIndex == 1) { //Camera roll
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [self userDidCancel];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"selectUserSegue"]) {
        CSKBSearchTableViewController *destinationVC = (CSKBSearchTableViewController *)segue.destinationViewController;
        destinationVC.imagePicked = self.imagePicked;
    }
}

- (void)userDidCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userSelectedPhoto
{
    [self performSegueWithIdentifier:@"selectUserSegue" sender:nil];
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self userDidCancel];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imagePicked  = [info valueForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self userSelectedPhoto];
    }];
    
}


@end
