//
//  Validator.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "Validator.h"

@implementation Validator

+ (BOOL)isObjectNilOrNull:(NSObject*)object {
    if (!object || [object isKindOfClass:[NSNull class]]) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)logValidationObject:(NSObject*)object andResult:(BOOL)isValid {
    if (!isValid) {
    }
}

+ (BOOL)isValidArray:(NSObject *)object {
    BOOL isValid = ![self isObjectNilOrNull:object];
    isValid &= [object isKindOfClass:[NSArray class]];
    [self logValidationObject:object andResult:isValid];
    return isValid;
}

+ (BOOL)isValidDictionary:(NSObject *)object {
    BOOL isValid = ![self isObjectNilOrNull:object];
    isValid &= [object isKindOfClass:[NSDictionary class]];
    [self logValidationObject:object andResult:isValid];
    return isValid;
}

+ (BOOL)isValidNumber:(NSObject *)object {
    BOOL isValid = ![self isObjectNilOrNull:object];
    if ([object isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber * myNumber = [f numberFromString:(NSString*)object];
        isValid &= [myNumber isKindOfClass:[NSNumber class]];
    } else {
        isValid &= [object isKindOfClass:[NSNumber class]];
    }
    [self logValidationObject:object andResult:isValid];
    return isValid;
}

+ (BOOL)isValidString:(NSObject *)object {
    BOOL isValid = ![self isObjectNilOrNull:object];
    NSString *string = (NSString*)object;
    isValid &= [string isKindOfClass:[NSString class]] && ([string isEqualToString:@""] || [string length] > 0);
    [self logValidationObject:object andResult:isValid];
    return isValid;
}

+ (BOOL)isValidLengthString:(NSObject *)object {
    BOOL isValid = ![self isObjectNilOrNull:object];
    NSString *string = (NSString*)object;
    isValid &=[string isKindOfClass:[NSString class]] && [string length] > 0;
    [self logValidationObject:object andResult:isValid];
    return isValid;
}

@end
