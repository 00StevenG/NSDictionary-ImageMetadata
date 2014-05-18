//
//  MetadataTableViewController.m
//  NSDictionary+ImageMetadata Example
//
//  Created by Steven Grace on 5/14/14.
//  Copyright (c) 2014 Steven Grace. All rights reserved.
//

#import "MetadataTableViewController.h"
#import "NSDictionary+ImageMetadata.h"
#import "NSDictionary+MetadataDatasource.h"

@interface MetadataTableViewController ()

@property (nonatomic, readwrite, strong) NSDictionary *metadata;

@end

@implementation MetadataTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageFilenameLabel.text = [self.imageURL lastPathComponent];
    self.metadata = [NSDictionary metadataWithImageAtURL:self.imageURL];
    self.tableView.dataSource = self.metadata;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
