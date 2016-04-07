//
//  ACFoursquareWSResponseTests.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 7/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ACFoursquareWSResponse.h"
#import "ACFoursquareWSClient.h"

@interface ACFoursquareWSResponseTests : XCTestCase

@end

@implementation ACFoursquareWSResponseTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testACFoursquareWSResponseIsInitializedWithNil {
    ACFoursquareWSResponse *response = [[ACFoursquareWSResponse alloc] init];
    
    XCTAssertNotNil(response);
    XCTAssertNil(response.json);
}

- (void)testACFoursquareWSResponseIsInitializedWithEmptyDictionary {
    
    NSDictionary *dict = [[NSDictionary alloc] init];
    ACFoursquareWSResponse *response = [[ACFoursquareWSResponse alloc] initWithJsonObject:dict];
    
    XCTAssertNotNil(response);
    XCTAssertNotNil(response.json);
    XCTAssertEqual([response.json count], 0);
}

- (void)testACFoursquareWSResponse {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Attempt retrieval of multiple coffee venues"];
    
    NSNumber *lat = [NSNumber numberWithDouble:-33.870775];
    NSNumber *lon = [NSNumber numberWithDouble:151.208414];
    NSNumber *meters = [NSNumber numberWithInt:100];
    
    NSMutableString *latituteLongitude = [NSMutableString stringWithString:[lat stringValue]];
    [latituteLongitude appendString:@","];
    [latituteLongitude appendString:[lon stringValue]];
    
    NSDictionary *parameters = @{
                                 @"ll":latituteLongitude,
                                 @"intent":@"browse",
                                 @"radius":[meters stringValue],
                                 @"limit":@"10"
                                 };
    
    NSMutableDictionary *allParameters = [NSMutableDictionary dictionaryWithDictionary:[ACFoursquareWSClient mandatoryParameters]];
    
    [allParameters addEntriesFromDictionary:parameters];
    
    [[ACFoursquareWSClient sharedInstance] GET:@"venues/search"
                                    parameters:allParameters
                                      progress:nil
                                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                           
                                           ACFoursquareWSResponse *wsResponse = [[ACFoursquareWSResponse alloc] initWithJsonObject:responseObject];
                                           
                                           XCTAssertNotNil(wsResponse, @"Response should not be nil");
                                           
                                           [expectation fulfill];
                                       }
                                       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           XCTFail(@"Request should succeed");
                                       }
     ];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout error: %@", error);
        }
    }];
}


@end
