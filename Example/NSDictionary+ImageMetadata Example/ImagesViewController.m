//
//  ViewController.m
//  NSDictionary+ImageMetadata Example
//
//  Created by Steven Grace on 5/13/14.
//  Copyright (c) 2014 Steven Grace. All rights reserved.
//

#import "ImagesViewController.h"
#import "MetadataTableViewController.h"
#import "NSBundle+ExampleAdditions.h"

@interface ImagesViewController () <UITableViewDataSource>

@property (nonatomic, readwrite, strong) NSArray *imageFileURLs;

@end

NSString *const kImageMetadataSegueIdentifier =  @"ImageMetadataSegue";
NSString *const kImageCellReuseIndentifier = @"imageCell";

@implementation ImagesViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageFileURLs = [[NSBundle mainBundle]imageURLsWithExtension:@"jpg"];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kImageMetadataSegueIdentifier])
    {
        MetadataTableViewController *metadataTableController = (MetadataTableViewController *)segue.destinationViewController;
        metadataTableController.imageURL = self.imageFileURLs[self.tableView.indexPathForSelectedRow.row];
    }
}

#pragma mark - TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.imageFileURLs count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:kImageCellReuseIndentifier forIndexPath:indexPath];
    
    NSURL *imageURL = self.imageFileURLs[indexPath.row];
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:[imageURL path]];
    cell.imageView.image = image;
    cell.textLabel.text = [imageURL lastPathComponent];
    return cell;
}


@end
