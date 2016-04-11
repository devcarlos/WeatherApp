//
//  ParseManager.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "ParseManager.h"

@implementation ParseManager

+ (ParseManager *)shared {
    static ParseManager *_instance = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _instance = [[ParseManager alloc] init];
    });
    return _instance;
}

-(Weather*)parseDataToWeatherFromDictionary:(NSDictionary*)dictionary{
    
    if ([Validator isValidDictionary:dictionary[@"data"]]) {
        Weather* weather = [[Weather alloc] initWithAttributes:dictionary[@"data"]];
        return weather;
    }
    
//    if ([Validator isValidDictionary:dictionary[@"data"]]) {
//        NSDictionary *data = dictionary[@"data"];
//        
//        weather.request = [[Request alloc] init];
//        NSLog(@"REQUEST: %@", data[@"request"]);
//        
//        weather.request.type = data[@"request"][0][@"type"];
//        weather.request.query = data[@"request"][0][@"query"];
//        
//        weather.current = [[CurrentCondition alloc] init];
//        
//        
//        //IF current condition IS valid
//        if ([Validator isValidArray:data[@"current_condition"]]) {
//            
//            weather.current.feelsLikeC = data[@"current_condition"][0][@"FeelsLikeC"];
//            weather.current.feelsLikeF = data[@"current_condition"][0][@"FeelsLikeF"];
//            weather.current.cloudcover = data[@"current_condition"][0][@"cloudcover"];
//            weather.current.humidity = data[@"current_condition"][0][@"humidity"];
//            weather.current.time = data[@"current_condition"][0][@"observation_time"];
//            weather.current.precipitationMM = data[@"current_condition"][0][@"precipMM"];
//            weather.current.pressure = data[@"current_condition"][0][@"pressure"];
//            weather.current.tempC = data[@"current_condition"][0][@"temp_C"];
//            weather.current.tempF = data[@"current_condition"][0][@"temp_F"];
//            weather.current.visibility = data[@"current_condition"][0][@"visibility"];
//            weather.current.weatherCode = data[@"current_condition"][0][@"weatherCode"];
//            weather.current.weatherDescription = data[@"current_condition"][0][@"weatherDesc"][0][@"value"];
//            weather.current.iconURL = data[@"current_condition"][0][@"weatherIconUrl"][0][@"value"];
//            weather.current.windDirection = data[@"current_condition"][0][@"winddir16Point"];
//            weather.current.windDegree = data[@"current_condition"][0][@"winddirDegree"];
//            weather.current.windSpeedMiles = data[@"current_condition"][0][@"windspeedMiles"];
//            weather.current.windSpeedKmph = data[@"current_condition"][0][@"windspeedKmph"];
//            
//        }
//        
//        
//        //Array
//        //    weather.forecasts = [NSArray alloc] init];
//        
//        return weather;
//    }
    
    return nil;
}

@end
