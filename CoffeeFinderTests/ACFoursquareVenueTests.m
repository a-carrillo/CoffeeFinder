//
//  ACFoursquareVenueTests.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 7/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ACFoursquareVenue.h"

static NSDictionary * ACJsonTestData() {
    NSString *json = @"{\"id\":\"4b09e0e4f964a520151f23e3\",\"location\":{\"distance\":323, \"formattedAddress\":[\"67 King St\",\"Sydney NSW 2001\",\"Australia\"],\"lat\": -33.868642577668574,\"lng\": 151.20604087706585},\"name\":\"Mecca Espresso\"}";
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
}

@interface ACFoursquareVenueTests : XCTestCase

@end

@implementation ACFoursquareVenueTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testACFoursquareVenueIsInitializedWithNil {
    ACFoursquareVenue *venue = [[ACFoursquareVenue alloc] init];
    
    XCTAssertNotNil(venue);
    XCTAssertNil(venue.json);
}

- (void)testAACFoursquareVenueIsInitializedWithEmptyDictionary {
    
    NSDictionary *dict = [[NSDictionary alloc] init];
    ACFoursquareVenue *venue = [[ACFoursquareVenue alloc] initWithJsonObject:dict];
    
    XCTAssertNotNil(venue);
    XCTAssertNotNil(venue.json);
    XCTAssertEqual([venue.json count], 0);
}

- (void)testAACFoursquareVenueIsInitializedWithJson {
    ACFoursquareVenue *venue = [[ACFoursquareVenue alloc] initWithJsonObject:ACJsonTestData()];
    
    XCTAssertNotNil(venue);
    XCTAssertNotNil(venue.json);
    XCTAssertEqual([venue.json count], 3);
}

@end
