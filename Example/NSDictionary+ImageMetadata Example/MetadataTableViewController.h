//
//  MetadataTableViewController.h
//  NSDictionary+ImageMetadata Example
//
//  Created by Steven Grace on 5/14/14.
//  Copyright (c) 2014 Steven Grace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetadataTableViewController : UITableViewController

@property (nonatomic, readwrite, weak) IBOutlet UILabel *imageFilenameLabel;
@property (nonatomic, readwrite, strong) NSURL *imageURL;

@end
