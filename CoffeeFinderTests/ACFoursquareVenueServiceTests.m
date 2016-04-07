//
//  ACFoursquareVenueServiceTests.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 7/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ACFoursquareVenuesService.h"

@interface ACFoursquareVenueServiceTests : XCTestCase

@end

@implementation ACFoursquareVenueServiceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetCoffeeVenues {
    ACFoursquareVenuesService *service = [[ACFoursquareVenuesService alloc] init];
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Attempt retrieval of multiple coffee venues"];
    
    NSNumber *lat = [NSNumber numberWithDouble:-33.870775];
    NSNumber *lon = [NSNumber numberWithDouble:151.208414];
    NSNumber *meters = [NSNumber numberWithInt:100];
    
    [service getCoffeeVenuesWithinMeters:meters ofLocationLatitude:lat longitude:lon withBlock:^(NSArray *venues, NSArray *errors) {
        
        if (!errors) {
            XCTAssertNotNil(venues);
            [expectation fulfill];
            
        } else {
            XCTFail(@"Request should succeed");
            
        }
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout error: %@", error);
        }
    }];
}


@end
