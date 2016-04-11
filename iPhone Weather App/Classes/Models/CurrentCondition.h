//
//  CurrentCondition.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentCondition : NSObject

@property (strong, nonatomic) NSString* time;
@property (strong, nonatomic) NSNumber* tempC;
@property (strong, nonatomic) NSNumber* tempF;
@property (strong, nonatomic) NSString* weatherCode;
@property (strong, nonatomic) NSString* iconURL;
@property (strong, nonatomic) NSString* weatherDescription;
@property (strong, nonatomic) NSNumber* windSpeedMiles;
@property (strong, nonatomic) NSNumber* windSpeedKmph;
@property (strong, nonatomic) NSNumber* windDegree;
@property (strong, nonatomic) NSString* windDirection;
@property (strong, nonatomic) NSNumber* precipitationMM;
@property (strong, nonatomic) NSNumber* humidity;
@property (strong, nonatomic) NSNumber* visibility;
@property (strong, nonatomic) NSNumber* pressure;
@property (strong, nonatomic) NSNumber* cloudcover;
@property (strong, nonatomic) NSNumber* feelsLikeC;
@property (strong, nonatomic) NSNumber* feelsLikeF;

- (id)initWithAttributes:(NSDictionary *)data;

-(NSString*)formatTemperatureImperial:(BOOL)useImperial;
-(NSString*)formatWindSpeedImperial:(BOOL)useImperial;

@end
