//
//  ACFoursquareWSClientTests.m
//  CoffeeFinder
//
//  Created by Alvaro Carrillo on 7/04/2016.
//  Copyright © 2016 Acarrillo Enterprises Pty Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ACFoursquareWSClient.h"

@interface ACFoursquareWSClientTests : XCTestCase

@property (nonatomic, strong) ACFoursquareWSClient *wsClient;

@end

@implementation ACFoursquareWSClientTests

- (void)setUp {
    [super setUp];
    self.wsClient = [ACFoursquareWSClient sharedInstance];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testWSClientSharedInstanceIsOnlyOne {
    XCTAssertTrue([[ACFoursquareWSClient sharedInstance] isEqual:self.wsClient]);
}

- (void)testWSClientInitFailsWithException {
    XCTAssertThrowsSpecific([[ACFoursquareWSClient alloc] init], NSException);
}


- (void)testWSClientMandatoryParameters {
    
    NSDictionary *mandatoryParameters = [ACFoursquareWSClient mandatoryParameters];
    
    XCTAssertTrue(mandatoryParameters, @"mandatoryParameters is not nil");
    XCTAssertTrue(mandatoryParameters.count == 4);
}

- (void)testWSClientConnectionRequest {
    
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Attempt retrieval of a venue"];
    
    [self.wsClient GET:@"venues/40a55d80f964a52020f31ee3" parameters:[ACFoursquareWSClient mandatoryParameters] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        XCTAssertNotNil(responseObject);
        [expectation fulfill];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error.localizedDescription);
        NSString* errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"%@", errorResponse);
        XCTFail(@"Request should succeed");
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout error: %@", error);
        }
    }];
}

@end
