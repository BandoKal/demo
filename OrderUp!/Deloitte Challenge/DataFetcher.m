//
//  DataFetcher.m
//  Deloitte Challenge
//
//  Created by Jason Bandy on 2/12/13.
//  Copyright (c) 2013 MTSU. All rights reserved.
//


#import "DataFetcher.h"

@implementation DataFetcher

-(NSArray*)fetchFeedWithURLPath: (NSString*) urlPath
{
    feedFetcherCalled = YES;
    [appDelegate.xmlArray removeAllObjects];
    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithContentsOfURL:[NSURL URLWithString:urlPath]];
    XMLParser *parser = [[XMLParser alloc]init];
    
    [xmlParser setDelegate:parser];
    
    BOOL success = [xmlParser parse];
    
    if (success)
    {
        NSLog(@"count inside: %i", [appDelegate.xmlArray count]);
        return [appDelegate xmlArray];
    }
    else
    {
        return nil;
    }
}

- (id)init
{
    if( [super init] )
    {
        feedFetcherCalled = NO;
        appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
    }
    return self;
}




-(NSString *) getStateAbbrWithFullName:(NSString*)state
{
    if ([state isEqualToString:@"Tennessee"])
    {
        return @"tn";
    }
    else
        return @"tn";
}

#pragma mark CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{    
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:manager.location
                   completionHandler:^(NSArray *placemarks, NSError *error)  {
                       CLPlacemark *placemark =  [placemarks lastObject];
                       NSMutableString *workerString = [[NSString stringWithFormat:@"%@", MENUISM_URL ] mutableCopy];
                       [workerString replaceOccurrencesOfString:@"[state]"
                                                     withString:[self getStateAbbrWithFullName:[placemark administrativeArea]]
                                                        options:nil
                                                          range: NSMakeRange(0, [workerString length]) ];
                       [workerString replaceOccurrencesOfString:@"[city]"
                                                     withString:[placemark locality]
                                                        options:nil
                                                          range: NSMakeRange(0, [workerString length]) ];
                                              
                       if (!feedFetcherCalled)
                             [self fetchFeedWithURLPath:workerString];
                       
                   }];
    [locationManager stopUpdatingLocation];
}


@end
