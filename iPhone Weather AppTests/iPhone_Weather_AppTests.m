//
//  iPhone_Weather_AppTests.m
//  iPhone Weather AppTests
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ForecastViewController.h"
#import "APIManager.h"
#import "ParseManager.h"

@interface iPhone_Weather_AppTests : XCTestCase

@property (nonatomic) ForecastViewController *forecastVCTest;
@property (nonatomic) NSString *query;
@property (nonatomic) Weather *weather;

@end

@implementation iPhone_Weather_AppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.forecastVCTest = [[UIStoryboard storyboardWithName:@"Forecast" bundle:nil] instantiateViewControllerWithIdentifier:@"Forecast"];
    self.query = @"Dublin";
    self.forecastVCTest.query = self.query;
    
}

- (void)testAPIManager {
    
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method"];
    [[APIManager shared] fetchForecastWithQuery:self.query
                                        success:^(NSDictionary *dictionary){
                                            
                                            //parse results
                                            self.weather = [[ParseManager shared] parseDataToWeatherFromDictionary:dictionary];
                                            
                                            //request finished timestamp
                                            self.weather.timestamp = [NSDate date];
                                            
                                            XCTAssertEqualObjects(@"Dublin, Ireland", self.weather.request.query, @"Query was not correct!");
                                            [completionExpectation fulfill];
                                        }
                                        failure:^(NSString *errorString) {
                                            NSLog(@"ERROR: %@", errorString);
                                        }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];

}

- (void)testPerformanceForecastAPICall {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        [self.forecastVCTest loadWeather];
    }];
}

@end
