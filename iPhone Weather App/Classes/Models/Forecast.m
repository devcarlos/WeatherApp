//
//  Forecast.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "Forecast.h"
#import "Validator.h"

@implementation Forecast

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
    
    //parse date as defined in format: "date": "2016-04-07"
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.date = [dateFormatter dateFromString:data[@"date"]];
    NSLog(@"DATE: %@", self.date);
    
    self.maxtempC = data[@"maxtempC"];
    NSLog(@"maxtempC: %@", self.maxtempC);
    
    self.maxtempF = data[@"maxtempF"];
    NSLog(@"maxtempF: %@", self.maxtempF);

    self.mintempC = data[@"mintempC"];
    NSLog(@"mintempC: %@", self.mintempC);
    
    self.mintempF = data[@"mintempF"];
    NSLog(@"mintempF: %@", self.mintempF);
    
    self.indexUV = data[@"uvIndex"];
    NSLog(@"indexUV: %@", self.indexUV);
    
    if ([Validator isValidArray:data[@"astronomy"]]) {
        self.astronomy = [[Astronomy alloc] initWithAttributes:data[@"astronomy"][0]];
    }
    
    if ([Validator isValidArray:data[@"hourly"]]) {
        
        NSMutableArray* hoursArray = [NSMutableArray new];
        
        for (NSDictionary* dict in data[@"hourly"]) {
            
            HourlyWeather* hour = [[HourlyWeather alloc] initWithAttributes:dict];
            
            if (hour != nil) {
                [hoursArray addObject:hour];
            }
        }
        self.hours = hoursArray;
    }
    
    return self;
}

#pragma mark - methods
-(NSString*) getHiLoImperial:(BOOL)useImperial {
    
    // Hi/Low temps
    if (useImperial) {
        NSString *result = [NSString stringWithFormat:@"%d° / %d°",
                            [self.maxtempF intValue],
                            [self.mintempF intValue]];
        return result;
    } else {
        NSString *result = [NSString stringWithFormat:@"%d° / %d°",
                            [self.maxtempC intValue],
                            [self.mintempC intValue]];
        return result;
    }
}

@end
