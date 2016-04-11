//
//  Request.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "Request.h"
#import "Validator.h"

@implementation Request

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
    
    self.type = data[@"type"];
    self.query = data[@"query"];
    
    NSLog(@"TYPE: %@", self.type);
    NSLog(@"QUERY: %@", self.query);
    
    return self;
}

@end
