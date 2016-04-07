//
//  ACFourSquareWSClient.h
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ACFoursquareWSClient : AFHTTPSessionManager

+ (ACFoursquareWSClient *)sharedInstance;
+ (NSDictionary *)mandatoryParameters;

@end
