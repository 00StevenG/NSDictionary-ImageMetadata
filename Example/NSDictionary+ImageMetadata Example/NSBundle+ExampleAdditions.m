//
//  NSBundle+ExampleAdditions.m
//  NSDictionary+ImageMetadata Example
//
//  Created by Steven Grace on 5/14/14.
//  Copyright (c) 2014 Steven Grace. All rights reserved.
//

#import "NSBundle+ExampleAdditions.h"

@implementation NSBundle (ExampleAdditions)

- (NSArray *)imageURLsWithExtension:(NSString *)ext
{
    NSMutableArray *mArr = [[NSMutableArray alloc]init];
    NSMutableArray *paths = [[NSMutableArray alloc]init];
    [paths addObjectsFromArray:[self pathsForResourcesOfType:ext inDirectory:nil]];
    
    for(NSString *aPath in paths)
    {
        NSURL *imageURL = [NSURL fileURLWithPath:aPath];
        [mArr addObject:imageURL] ;
    }
    return [mArr copy];
}



@end
