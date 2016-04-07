//
//  ACFoursquareVenuesService.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import "ACFoursquareVenuesService.h"
#import "ACFoursquareWSClient.h"
#import "ACFoursquareWSResponse.h"
#import "ACFoursquareVenue.h"

@implementation ACFoursquareVenuesService

/**
 *  Searches for coffee venues within the meters specified from the location specified
 *  by the latitude and longitude coordinates.
 *
 *  @param meters    radius in meters to search within from the location specified by latitude and longitude
 *  @param latitude  the latitude coordinate of the location
 *  @param longitude the longitude coordinate of the location
 *  @param block     the block that will return the venues or errors
 */
- (void)getCoffeeVenuesWithinMeters:(NSNumber *)meters ofLocationLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude withBlock:(void(^)(NSArray *venues, NSArray *errors))block
{
    NSString *path = @"venues/search";
    
    NSMutableString *latituteLongitude = [NSMutableString stringWithString:[latitude stringValue]];
    [latituteLongitude appendString:@","];
    [latituteLongitude appendString:[longitude stringValue]];
    
    // the category identifiers can be found at https://developer.foursquare.com/categorytree
    // we will be using Cafe (4bf58dd8d48988d16d941735) and Coffee Shop (4bf58dd8d48988d1e0931735)
    NSString *categoryId = @"4bf58dd8d48988d16d941735,4bf58dd8d48988d1e0931735";
    
    NSDictionary *parameters = @{
                                 @"ll":latituteLongitude,
                                 @"intent":@"browse",
                                 @"radius":[meters stringValue],
                                 @"limit":@"20",
                                 @"categoryId":categoryId
                                 };
    
    NSMutableDictionary *allParameters = [NSMutableDictionary dictionaryWithDictionary:[ACFoursquareWSClient mandatoryParameters]];
    
    [allParameters addEntriesFromDictionary:parameters];
    
    [[ACFoursquareWSClient sharedInstance] GET:path
                                    parameters:allParameters
                                      progress:nil
                                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                           
                                           ACFoursquareWSResponse *wsResponse = [[ACFoursquareWSResponse alloc] initWithJsonObject:responseObject];
                                           
                                           NSMutableArray *fsVenues = [[NSMutableArray alloc] init];
                                           
                                           NSArray *venuesInResponse = wsResponse.response[@"venues"];
                                           
                                           for (NSDictionary *venueJson in venuesInResponse) {
                                               ACFoursquareVenue *fsVenue = [[ACFoursquareVenue alloc] initWithJsonObject:venueJson];
                                               [fsVenues addObject:fsVenue];
                                           }
                                           
                                           if (block) {
                                               block(fsVenues, nil);
                                           }
                                       }
                                       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           NSLog(@"Error: %@", error.localizedDescription);
                                           NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                                           NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:nil];
                                          
                                           ACFoursquareWSResponse *wsResponse = [[ACFoursquareWSResponse alloc] initWithJsonObject:jsonObject];
                                           
                                           
                                           
                                           NSArray *errors = @[wsResponse];
                                           
                                           if (block) {
                                               block(nil, errors);
                                           }
                                       }
     ];
    
}

@end
