//
//  APIManager.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+ (APIManager *)shared {
    static APIManager *_instance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _instance = [[APIManager alloc] init];
    });
    return _instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.HTTPClient = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kApiBaseURL]];
    }
    return self;
}

#pragma mark - BASE API CALLS

- (BOOL)connected {
    if ([[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] == AFNetworkReachabilityStatusNotReachable) {
        return NO;
    }
    return YES;
}

- (void)getCallAtPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary* dictionary))success failure:(void(^)(NSString* errorString))failure {
    
    if (![self connected]) {
        failure(@"There was an error on the Internet connection. Please check your connection.");
        return;
    }
    
    [self.HTTPClient GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error.localizedDescription);
    }];
}

#pragma mark - Fetch Data Functions

- (void)fetchForecastWithQuery:(NSString*)query success:(void(^)(NSDictionary* dictionary))success failure:(void(^)(NSString* errorString))failure {
    
    NSString *path = [NSString stringWithFormat:@"%@", kWeatherPath];
    NSMutableDictionary* params = [NSMutableDictionary dictionary];

    [params setObject:API_KEY forKey:kParamApiKey];
    [params setObject:[NSNumber numberWithInt:kParamNumDaysValue] forKey:kParamNumDays];
    [params setObject:kFormatValue forKey:kParamFormat];
    [params setObject:query forKey:kParamQuery];
    
    //API base callback
    [self getCallAtPath:path parameters:params success:success failure:failure];
}

@end
