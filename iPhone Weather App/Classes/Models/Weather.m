//
//  Weather.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "Weather.h"
#import "Validator.h"

@implementation Weather

- (id)initWithAttributes:(NSDictionary *)data {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    //check valid NSDictionary
    if (![Validator isValidDictionary:data]) {
        NSLog(@"Invalid Data");
        return nil;
    }
    
    if ([Validator isValidArray:data[@"request"]]) {
        self.request = [[Request alloc] initWithAttributes:data[@"request"][0]];
    }
    
    if ([Validator isValidArray:data[@"current_condition"]]) {
        self.current = [[CurrentCondition alloc] initWithAttributes:data[@"current_condition"][0]];
    }
    
    if ([Validator isValidArray:data[@"weather"]]) {
        
        NSMutableArray* forecastsArray = [NSMutableArray new];
        
        for (NSDictionary* dict in data[@"weather"]) {
            
            Forecast* forecast = [[Forecast alloc] initWithAttributes:dict];
            
            if (forecast != nil) {
                [forecastsArray addObject:forecast];
            }
        }
        self.forecasts = forecastsArray;
    }
    
    return self;
}

@end
