//
//  Validator.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

+ (BOOL)isValidArray:(NSObject*)object;
+ (BOOL)isValidDictionary:(NSObject*)object;
+ (BOOL)isValidNumber:(NSObject*)object;
+ (BOOL)isValidString:(NSObject*)object;
+ (BOOL)isValidLengthString:(NSObject*)object;

@end
