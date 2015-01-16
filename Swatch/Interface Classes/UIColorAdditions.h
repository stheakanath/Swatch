//
//  UIColor+UIColorAdditions.h
//  Swatch
//
//  Created by Sony Theakanath on 1/15/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (UIColorAdditions)

+ (NSString *)stringFromUIColor:(UIColor *)color;


@end

@interface NSString (UIColorAdditions)

+ (UIColor *)colorFromNSString:(NSString *)string;
+ (NSString *)cleanStringFromUIColor: (UIColor *) color;
+ (NSString *)hexStringForColor:(UIColor *)color;
+ (int)totalvalue: (UIColor *) color;

@end
