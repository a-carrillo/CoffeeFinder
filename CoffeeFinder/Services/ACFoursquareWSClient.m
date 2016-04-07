//
//  ACFourSquareWSClient.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 6/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import "ACFoursquareWSClient.h"

@implementation ACFoursquareWSClient

/**
 *  The Foursquare web service client
 *
 *  @return The Foursquare web service client shared instance (i.e. singleton)
 */
+ (ACFoursquareWSClient *) sharedInstance
{
    static ACFoursquareWSClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    NSString *endpoint = @"https://api.foursquare.com/v2/";
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:endpoint]];
    });
    
    return _sharedInstance;
}

/**
 *  The initialiser will simply return an exception describing the way in which
 *  this class should be used.
 *
 *  @return An NSException describing the usage
 */
- (instancetype) init
{
    // init should not be called
    [NSException raise:@"Singleton" format:@"Use +[ACFourSquareWSClient sharedInstance]"];
    return nil;
}

/**
 *  The parameters that must be included the query string of each web service call.
 *
 *  They include: client_id, client_secret, v (version - a YYYYMMDD timestamp indicating the date until API changes are accepted)
 *  and m (mode - either foursquare or swarm style API responses)
 *
 *  Note: It is possible to do a bit more to secure the client_id and client_secret, but after considering options such as obfuscation etc
 *  it was decided to leave as is since they will be passed as a parameter in the query string of a URL.
 *
 *  @return The mandatory parameters in an NSDictionary
 */
+ (NSDictionary *)mandatoryParameters
{
    static NSDictionary *_mandatoryParameters;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _mandatoryParameters = @{
                              @"client_id":@"ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G",
                              @"client_secret":@"YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL",
                              @"v":@"20160406",
                              @"m":@"foursquare"
                              };
    });
    
    return _mandatoryParameters;
}

@end
