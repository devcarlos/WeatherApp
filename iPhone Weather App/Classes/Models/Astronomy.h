//
//  Astronomy.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/8/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Astronomy : NSObject

@property (strong, nonatomic) NSString* sunrise;
@property (strong, nonatomic) NSString* sunset;
@property (strong, nonatomic) NSString* moonrise;
@property (strong, nonatomic) NSString* moonset;

- (id)initWithAttributes:(NSDictionary *)data;

@end
