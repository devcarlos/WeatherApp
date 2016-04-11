//
//  Request.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject

@property (strong, nonatomic) NSString* type;
@property (strong, nonatomic) NSString* query;

- (id)initWithAttributes:(NSDictionary *)data;

@end
