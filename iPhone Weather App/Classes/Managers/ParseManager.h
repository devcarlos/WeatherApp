//
//  ParseManager.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Validator.h"
#import "Weather.h"

@interface ParseManager : NSObject

//shared
+ (ParseManager *)shared;

-(Weather*)parseDataToWeatherFromDictionary:(NSDictionary*)dictionary;

@end
