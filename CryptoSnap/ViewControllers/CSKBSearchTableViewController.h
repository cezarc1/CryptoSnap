//
//  CSKBSearchTableViewController.h
//  CryptoSnap
//
//  Created by Cezar Cocu on 4/27/14.
//  Copyright (c) 2014 CryptoSnap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSKBSearchTableViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) UIImage *imagePicked;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *searchResults;

@end
