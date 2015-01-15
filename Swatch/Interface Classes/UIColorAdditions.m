//
//  UIColor+UIColorAdditions.m
//  Swatch
//
//  Created by Sony Theakanath on 1/15/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "UIColorAdditions.h"

@implementation UIColor (UIColorAdditions)

+ (NSString *)stringFromUIColor:(UIColor *)color {
    return [NSString stringWithFormat:@"%@", color ];
}
@end

@implementation NSString (UIColorAdditions)

+ (UIColor*)colorFromNSString:(NSString *)string {
    // The string should be something like "UIDeviceRGBColorSpace 0.5 0 0.25 1
    NSArray *values = [string componentsSeparatedByString:@" "];
    CGFloat red = [[values objectAtIndex:1] floatValue];
    CGFloat green = [[values objectAtIndex:2] floatValue];
    CGFloat blue = [[values objectAtIndex:3] floatValue];
    CGFloat alpha = [[values objectAtIndex:4] floatValue];
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    return color;
}
@end
