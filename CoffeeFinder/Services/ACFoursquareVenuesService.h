//
//  ACFoursquareVenuesService.h
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACFoursquareVenuesService : NSObject

- (void)getCoffeeVenuesWithinMeters:(NSNumber *)meters ofLocationLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude withBlock:(void(^)(NSArray *venues, NSArray *errors))block;

@end
