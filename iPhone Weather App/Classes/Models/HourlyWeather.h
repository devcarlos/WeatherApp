//
//  HourlyWeather.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/8/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentCondition.h"

@interface HourlyWeather : NSObject

@property (strong, nonatomic) CurrentCondition* condition;
@property (strong, nonatomic) NSNumber* heatIndexC;
@property (strong, nonatomic) NSNumber* heatIndexF;
@property (strong, nonatomic) NSNumber* dewPointC;
@property (strong, nonatomic) NSNumber* dewPointF;
@property (strong, nonatomic) NSNumber* windChillC;
@property (strong, nonatomic) NSNumber* windChillF;
@property (strong, nonatomic) NSNumber* windGustMiles;
@property (strong, nonatomic) NSNumber* windGustKmph;
@property (strong, nonatomic) NSNumber* chanceofrain;
@property (strong, nonatomic) NSNumber* chanceofremdry;
@property (strong, nonatomic) NSNumber* chanceofwindy;
@property (strong, nonatomic) NSNumber* chanceofovercast;
@property (strong, nonatomic) NSNumber* chanceofsunshine;
@property (strong, nonatomic) NSNumber* chanceoffrost;
@property (strong, nonatomic) NSNumber* chanceofhightemp;
@property (strong, nonatomic) NSNumber* chanceoffog;
@property (strong, nonatomic) NSNumber* chanceofsnow;
@property (strong, nonatomic) NSNumber* chanceofthunder;


- (id)initWithAttributes:(NSDictionary *)data;

@end
