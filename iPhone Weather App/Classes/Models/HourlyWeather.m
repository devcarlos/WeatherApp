//
//  HourlyWeather.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/8/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "HourlyWeather.h"
#import "Validator.h"

@implementation HourlyWeather

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
    
    self.condition = [[CurrentCondition alloc] initWithAttributes:data];
    self.heatIndexC = data[@"heatIndexC"];
    self.heatIndexF = data[@"heatIndexF"];
    self.dewPointC = data[@"dewPointC"];
    self.dewPointF = data[@"dewPointF"];
    self.windChillC = data[@"windChillC"];
    self.windChillF = data[@"windChillF"];
    self.windGustMiles = data[@"windGustMiles"];
    self.windGustKmph = data[@"windGustKmph"];
    self.chanceofrain = data[@"chanceofrain"];
    self.chanceofremdry = data[@"chanceofremdry"];
    self.chanceofwindy = data[@"chanceofwindy"];
    self.chanceofovercast = data[@"chanceofovercast"];
    self.chanceofsunshine = data[@"chanceofsunshine"];
    self.chanceoffrost = data[@"chanceoffrost"];
    self.chanceofhightemp = data[@"chanceofhightemp"];
    self.chanceoffog = data[@"chanceoffog"];
    self.chanceofsnow = data[@"chanceofsnow"];
    self.chanceofthunder = data[@"chanceofthunder"];
    
    return self;
}

@end
