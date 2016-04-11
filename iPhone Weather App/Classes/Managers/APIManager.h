//
//  APIManager.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"

@interface APIManager : NSObject

@property (strong, nonatomic) AFHTTPSessionManager* HTTPClient;

//shared
+ (APIManager *)shared;

//retrieve data functions
- (void)fetchForecastWithQuery:(NSString*)query success:(void(^)(NSDictionary* dictionary))success failure:(void(^)(NSString* errorString))failure;

@end
