//
//  CurrentCondition.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "CurrentCondition.h"
#import "Validator.h"

@implementation CurrentCondition

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
    
    self.feelsLikeC = data[@"FeelsLikeC"];
    self.feelsLikeF = data[@"FeelsLikeF"];
    self.cloudcover = data[@"cloudcover"];
    self.humidity = data[@"humidity"];
    
    if ([data objectForKey:@"observation_time"]) {
        self.time = data[@"observation_time"];
    } else if ([data objectForKey:@"time"]) {
        self.time = data[@"time"];
    }
    
    self.precipitationMM = data[@"precipMM"];
    self.pressure = data[@"pressure"];
    
    if ([data objectForKey:@"temp_C"]) {
        self.tempC = data[@"temp_C"];
    } else if ([data objectForKey:@"tempC"]) {
        self.tempC = data[@"tempC"];
    }
    
    if ([data objectForKey:@"temp_F"]) {
        self.tempF = data[@"temp_F"];
    } else if ([data objectForKey:@"tempF"]) {
        self.tempF = data[@"tempF"];
    }
    
    self.visibility = data[@"visibility"];
    self.weatherCode = data[@"weatherCode"];
    self.weatherDescription = data[@"weatherDesc"][0][@"value"];
    self.iconURL = data[@"weatherIconUrl"][0][@"value"];
    self.windDirection = data[@"winddir16Point"];
    self.windDegree = data[@"winddirDegree"];
    self.windSpeedMiles = data[@"windspeedMiles"];
    self.windSpeedKmph = data[@"windspeedKmph"];

    NSLog(@"TIME: %@", self.time);
    NSLog(@"FEELS LIKE C: %@", self.feelsLikeC);
    NSLog(@"FEELS LIKE F: %@", self.feelsLikeF);
    NSLog(@"CLOUDCOVER: %@", self.cloudcover);
    NSLog(@"HUMIDITY: %@", self.humidity);
    NSLog(@"PRECIPITATIONMM: %@", self.precipitationMM);
    NSLog(@"PRESSURE: %@", self.pressure);
    NSLog(@"TEMP C: %@", self.tempC);
    NSLog(@"TEMP F: %@", self.tempF);
    NSLog(@"VISIBILITY: %@", self.visibility);
    NSLog(@"CODE: %@", self.weatherCode);
    NSLog(@"DESC: %@", self.weatherDescription);
    NSLog(@"ICON URL: %@", self.iconURL);
    NSLog(@"WIND DIRECTION: %@", self.windDirection);
    NSLog(@"WIND DEGREEE: %@", self.windDegree);
    NSLog(@"WIND MILES: %@", self.windSpeedMiles);
    NSLog(@"WIND KMPH: %@", self.windSpeedKmph);
    
    return self;
}

#pragma mark - Format Methods

-(NSString*)formatTemperatureImperial:(BOOL)useImperial {
    //imperial: Fº or normal: Cº
    if (useImperial) {
        return [NSString stringWithFormat:@"%d°", [self.tempF intValue]];
    } else {
        return [NSString stringWithFormat:@"%d°", [self.tempC intValue]];
    }
}

-(NSString*)formatWindSpeedImperial:(BOOL)useImperial {
    if (useImperial) {
        return [NSString stringWithFormat:@"%u mph", [self.windSpeedMiles intValue]];
    } else {
        return [NSString stringWithFormat:@"%u kmph", [self.windSpeedKmph intValue]];
    }
}


@end
