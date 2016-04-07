//
//  ACFoursquareWSResponse.h
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACFoursquareWSResponse : NSObject

@property (nonatomic, copy, readonly)NSDictionary *json;
@property (nonatomic, copy, readonly)NSDictionary *response;
@property (nonatomic, copy, readonly)NSDictionary *meta;
@property (nonatomic, copy, readonly)NSDictionary *notifications;

- (instancetype)initWithJsonObject:(NSDictionary *)jsonObject;

@end
