//
//  CSReceivedImagesTableViewController.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 5/6/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "CSReceivedImagesTableViewController.h"
#import <Parse/Parse.h>
#import "URBMediaFocusViewController.h"
#import "CSPhotoTableViewCell.h"
#import "SVProgressHUD.h"

@interface CSReceivedImagesTableViewController ()

@property (nonatomic, strong) URBMediaFocusViewController *mediaFocusController;

@end

@implementation CSReceivedImagesTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshData)
                                                 name:@"PhotoPostedToParse"
                                               object:nil];
    self.mediaFocusController = [[URBMediaFocusViewController alloc] init];
    [self setUpRefreshControl];
    
    [self refreshData];
}

- (void)setUpRefreshControl
{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshData)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refreshData
{
    [SVProgressHUD showWithStatus:@"Refreshing Photos"];
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query whereKey:@"to" equalTo:[PFUser currentUser].username];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [SVProgressHUD dismiss];
        [self.refreshControl endRefreshing];
        if (!error) {
            
            self.receivedImages = objects;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"Error retrieving sent Images : %@", error);
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSPhotoTableViewCell *cell = (CSPhotoTableViewCell *) [self.tableView cellForRowAtIndexPath:indexPath];
    [self.mediaFocusController showImage:cell.imageReceived.image fromView:self.view];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.receivedImages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCellIdentifier"];
    
    [cell configureForPFObject:self.receivedImages[indexPath.row]];
    
    return cell;
}


@end
