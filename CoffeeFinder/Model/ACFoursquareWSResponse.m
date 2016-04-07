//
//  ACFoursquareWSResponse.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import "ACFoursquareWSResponse.h"

@implementation ACFoursquareWSResponse

- (instancetype)initWithJsonObject:(NSDictionary *)jsonObject;
{
    self = [super init];
    
    if (self) {
        _json = jsonObject;
        
        if (_json) {
            //overview on the structure of responses can be found at https://developer.foursquare.com/overview/responses
            _response = _json[@"response"];
            _meta = _json[@"meta"];
            _notifications = _json[@"notifications"];
        }
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithJsonObject:nil];
}

@end
