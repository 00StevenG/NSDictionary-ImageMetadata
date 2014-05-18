//
//  NSMutableDictionary+ImageMetadata.m
//  NSDictionary-ImageMetadata
//
//  Created by Steven Grace on 4/22/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "NSDictionary+ImageMetadata.h"

@implementation NSDictionary (ImageMetadata)

#pragma mark Metadata Fetching

+ (NSDictionary*)imageMetadataWithImageAtURL:(NSURL*)url
{
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)url, NULL);
    
    if (!imageSource) {
        NSLog(@"%s failed to create image at url: %@",__PRETTY_FUNCTION__,url);
        return nil;
    }
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:NO], (NSString *)kCGImageSourceShouldCache,
                             nil];
    CFDictionaryRef imageProperties =CGImageSourceCopyPropertiesAtIndex(imageSource,0,(__bridge CFDictionaryRef)options);
    CFRelease(imageSource);
    NSMutableDictionary* metadata = [NSMutableDictionary dictionaryWithDictionary:(__bridge NSDictionary*)imageProperties];
    CFRelease(imageProperties);
    return metadata;
}

#pragma mark - Public Property Fetching

- (id)sgg_valueForProperty:(NSString *)property
{
    return [self sgg_recursiveObjectForKey:property];
}

#pragma mark - Formatted Property Helpers

- (NSString*)sgg_formattedShutterSpeed
{
    NSNumber* time = [self sgg_recursiveObjectForKey:(id)kCGImagePropertyExifShutterSpeedValue];
    float d=1/[time floatValue];
    return [NSString stringWithFormat:@"1/%g",ceilf(d)];
}

- (NSString*)sgg_formattedApetureValue
{
    return [NSString stringWithFormat:@"f/%@",[self sgg_recursiveObjectForKey:(id)kCGImagePropertyExifApertureValue]];
}

#pragma mark - Location

- (CLLocation*)sgg_location
{
    NSDictionary *GPSdictionary = [self objectForKey:(id)kCGImagePropertyGPSDictionary];
    if (GPSdictionary) {
        
        CLLocationDegrees latituteDegress = [[GPSdictionary objectForKey:(id)kCGImagePropertyGPSLatitude] floatValue];
        CLLocationDegrees longitudeDegress = [[GPSdictionary objectForKey:(id)kCGImagePropertyGPSLongitude] floatValue];
        NSString *latitudeRef = [GPSdictionary objectForKey:(id)kCGImagePropertyGPSLatitudeRef];
        NSString *longtiudeRef = [GPSdictionary objectForKey:(id)kCGImagePropertyGPSLongitudeRef];
        
        if ([@"S" isEqualToString:latitudeRef]) {
            latituteDegress *= -1.0f;
        }
                
        if ([@"W" isEqualToString:longtiudeRef]) {
            longitudeDegress *= -1.0f;
        }
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:latituteDegress longitude:longitudeDegress];
        return location;
    }
    return nil;
}

- (CLLocationDirection)sgg_trueHeading
{
    NSDictionary *GPSinfo = [self objectForKey:(id)kCGImagePropertyGPSDictionary];
    CLLocationDirection heading = 0;
    if (GPSinfo) {
        heading =[[GPSinfo objectForKey:(id)kCGImagePropertyGPSImgDirection] doubleValue];
    }
    return heading;
}

#pragma mark- NSDictionary Recursive

- (id)sgg_recursiveObjectForKey:(NSString *)key
{    
    if ([self.allKeys containsObject:key]) {
        return [self objectForKey:key];
    }
    
    for (NSString *k in self.allKeys)
    {
        id obj = [self objectForKey:k];
        if([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *d = (NSDictionary *)obj;
            id child = [d sgg_recursiveObjectForKey:key];
            if(child) return child;
            
        } else if([obj isKindOfClass:[NSArray class]]) {
            
            // loop through the NSArray and traverse any dictionaries found
            NSArray *a = (NSArray *)obj;
            for(id child in a) {
                if([child isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *d = (NSDictionary *)child;
                    id o = [d sgg_recursiveObjectForKey:key];
                    if(o) return o;
                }
            }
        }
    }
    // the key was not found in this dictionary or any of it's children
    return nil;
}
@end
