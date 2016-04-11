//
//  Astronomy.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/8/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "Astronomy.h"
#import "Validator.h"

@implementation Astronomy

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
    
    self.sunrise = data[@"sunrise"];
    self.sunset = data[@"sunset"];
    self.moonrise = data[@"moonrise"];
    self.moonset = data[@"moonset"];
    
    NSLog(@"SUNRISE: %@", self.sunrise);
    NSLog(@"SUNSET: %@", self.sunset);
    NSLog(@"MOONRISE: %@", self.moonrise);
    NSLog(@"MOONSET: %@", self.moonset);
    
    return self;
}

@end
