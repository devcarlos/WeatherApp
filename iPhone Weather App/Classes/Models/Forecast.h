//
//  Forecast.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Astronomy.h"
#import "HourlyWeather.h"

@interface Forecast : NSObject

@property (strong, nonatomic) NSDate* date;
@property (strong, nonatomic) NSNumber* maxtempC;
@property (strong, nonatomic) NSNumber* maxtempF;
@property (strong, nonatomic) NSNumber* mintempC;
@property (strong, nonatomic) NSNumber* mintempF;
@property (strong, nonatomic) NSNumber* indexUV;
@property (strong, nonatomic) Astronomy* astronomy;
@property (strong, nonatomic) NSArray* hours;

- (id)initWithAttributes:(NSDictionary *)data;

-(NSString*) getHiLoImperial:(BOOL)useImperial;

@end
