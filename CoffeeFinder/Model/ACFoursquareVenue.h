//
//  ACFoursquareVenue.h
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACFoursquareVenue : NSObject

@property (nonatomic, copy, readonly)NSDictionary *json;
@property (nonatomic, copy, readonly)NSString *id;
@property (nonatomic, copy, readonly)NSString *name;
@property (nonatomic, copy, readonly)NSArray *address;
@property (nonatomic, copy, readonly)NSNumber *distanceInMeters;
@property (nonatomic, copy, readonly)NSNumber *latitude;
@property (nonatomic, copy, readonly)NSNumber *longitude;

- (instancetype)initWithJsonObject:(NSDictionary *)jsonObject;

@end
