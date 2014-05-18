//
//  CSKBSearchTableViewController.m
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/27/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import "CSKBSearchTableViewController.h"
#import "KBUser+Requests.h"
#import "KBUserTableViewCell.h"
#import "SVProgressHUD.h"

@interface CSKBSearchTableViewController ()

@end

@implementation CSKBSearchTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KBUserCellIdentifier"];
    
    [cell configureCellForUser:self.searchResults[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBUser *selectedUser = self.searchResults[indexPath.row];
    [selectedUser sendImage:self.imagePicked];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userDidPostImage" object:nil];
    [SVProgressHUD showSuccessWithStatus:@"Sent Image"];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [SVProgressHUD showWithStatus:@"Searching KeyBase"];
    [searchBar resignFirstResponder];
    
    [KBUser searchForUsersWithName:searchBar.text
                       withSuccess:^(NSArray *users) {
                           [SVProgressHUD dismiss];
                           self.searchResults = users;
                           [self.tableView reloadData];
                       }
                       andFailiure:^(NSError *err) {
                           [SVProgressHUD dismiss];
                       }];
}


@end
