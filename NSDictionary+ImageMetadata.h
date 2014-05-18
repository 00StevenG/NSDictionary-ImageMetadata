//
//  NSMutableDictionary+ImageMetadata.h
//  NSDictionary-ImageMetadata
//
//  Created by Steven Grace on 4/22/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//  www.works5.com
//
//  Category Methods for fetching and working with Image Metadata;
//  More information on the specific properties can be found at in ImageIO
//
//#include <ImageIO/CGImageProperties.h>

@interface NSDictionary (ImageMetadata)

+ (NSDictionary*)imageMetadataWithImageAtURL:(NSURL *)url;

// pass in CGImageProperty value (recursively searched in sub dictionaries)
- (id)sgg_valueForProperty:(NSString *)property;

// UI Formatted/Readable Variants
@property (nonatomic,readonly) NSString* sgg_formattedShutterSpeed;
@property (nonatomic,readonly) NSString* sgg_formattedApetureValue;

// Location (calculated from GPS Metadata)
@property (nonatomic,readonly) CLLocation* sgg_location;
@property (nonatomic,readonly) CLLocationDirection sgg_trueHeading;

@end
