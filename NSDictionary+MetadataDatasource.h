//
//  NSMutableDictionary+MetadataDatasource.h
//  NSDictionary-ImageMetadata
//
//  Created by Steven Grace on 4/21/14.
//  Copyright (c) 2014 Steven Grace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MetadataDatasource) <UITableViewDataSource>

/*
  Tableview dataource
*/
// A default implementation using Basic UITableViewCells
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
  IndexPath based queries
*/
// Use for more customized Tableviews
- (NSUInteger)sgg_numberOfRowsInSection:(NSUInteger)section;
- (NSString *)sgg_propertyForIndexPath:(NSIndexPath*)indexPath;
- (NSString*)sgg_valueForPropertyAtIndexPath:(NSIndexPath*)indexPath;

@end
