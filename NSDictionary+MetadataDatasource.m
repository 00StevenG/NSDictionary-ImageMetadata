//
//  NSMutableDictionary+MetadataDatasource.m
//  NSDictionary-ImageMetadata
//
//  Created by Steven Grace on 4/21/14.
//  Copyright (c) 2014 Steven Grace. All rights reserved.
//

#import "NSDictionary+MetadataDatasource.h"
#import "NSDictionary+ImageMetadata.h"

@implementation NSDictionary (MetadataDatasource)

#pragma mark - TableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self allKeys]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self sgg_numberOfRowsInSection:section];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self sgg_titleForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ImageMetadataCell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    NSString *property = [self sgg_propertyForIndexPath:indexPath];
    cell.textLabel.text = property;

    if([property isEqualToString:(id)kCGImagePropertyExifShutterSpeedValue])
    {
        cell.detailTextLabel.text = [self sgg_formattedShutterSpeed];
    }
    else if([property isEqualToString:(id)kCGImagePropertyExifApertureValue])
    {
        cell.detailTextLabel.text = [self sgg_formattedApetureValue];
    }
    else{
        cell.detailTextLabel.text = [self sgg_valueForPropertyAtIndexPath:indexPath];
    }
    
    NSLog(@"%@",[self sgg_valueForPropertyAtIndexPath:indexPath]);
    return cell;
}

- (NSUInteger)sgg_numberOfRowsInSection:(NSUInteger)section
{
    NSInteger count = 1;
    NSString* key = [[self allKeys] objectAtIndex:section];
    id result =[self objectForKey:key];
    if([result isKindOfClass:[NSDictionary class]]){
        count = [result count];
    }
    return count;
}

- (NSString*)sgg_titleForSection:(NSUInteger)section
{
    NSString* key = [[self allKeys] objectAtIndex:section];
    NSString* metatdataSectionKey = [NSString stringWithFormat:@"%@",key];
    
    if([metatdataSectionKey rangeOfString:@"{"].length>0){
        return [[metatdataSectionKey stringByReplacingOccurrencesOfString:@"{" withString:@""]stringByReplacingOccurrencesOfString:@"}" withString:@""];
    }
    return key;
}

#pragma mark - Indexpath Queries

- (NSString *)sgg_propertyForIndexPath:(NSIndexPath*)indexPath
{
    NSString* key = [[self allKeys] objectAtIndex:indexPath.section];
    NSInteger rowsInSection = [self sgg_numberOfRowsInSection:indexPath.section];
    if (rowsInSection==1) {
        return key;
    }
    else {
        NSDictionary* info =[self objectForKey:key];
        NSArray* keys = [info allKeys];
        NSString* str = [keys objectAtIndex:indexPath.row];
        return str;
    }
}

- (NSString*)sgg_valueForPropertyAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* key = [[self allKeys] objectAtIndex:indexPath.section];
    NSInteger rowsInSection = [self sgg_numberOfRowsInSection:indexPath.section];
    if(rowsInSection==1){
        NSDictionary* info =[self objectForKey:key];
        return [NSString stringWithFormat:@"%@",info];
    }
    
    NSDictionary* info =[self objectForKey:key];
    NSArray* keys = [info allKeys];
    NSString* str = [keys objectAtIndex:indexPath.row];
    
    return [NSString stringWithFormat:@"%@",[info objectForKey:str]];
}


@end
