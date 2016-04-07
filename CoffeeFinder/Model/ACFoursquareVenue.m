//
//  ACFoursquareVenue.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import "ACFoursquareVenue.h"

@implementation ACFoursquareVenue

- (instancetype)initWithJsonObject:(NSDictionary *)jsonObject;
{
    self = [super init];
    
    if (self) {
        _json = jsonObject;
        
        if (_json) {
            _id = _json[@"id"];
            _name = _json[@"name"];
            
            NSDictionary *location = _json[@"location"];
            
            if (location) {
                _address = location[@"formattedAddress"];
                _distanceInMeters = [NSNumber numberWithDouble:[location[@"distance"] doubleValue]];
                _latitude = [NSNumber numberWithDouble:[location[@"lat"] doubleValue]];
                _longitude = [NSNumber numberWithDouble:[location[@"lng"] doubleValue]];
            }
        }
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithJsonObject:nil];
}

@end
