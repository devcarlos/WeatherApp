//
//  Weather.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "CurrentCondition.h"
#import "Forecast.h"

@interface Weather : NSObject

@property (nonatomic, retain) NSDate* timestamp;
@property (strong, nonatomic) Request* request;
@property (strong, nonatomic) CurrentCondition* current;
@property (strong, nonatomic) NSArray* forecasts;

- (id)initWithAttributes:(NSDictionary *)data;

@end
