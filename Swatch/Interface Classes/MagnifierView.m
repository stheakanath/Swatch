//
//  MagnifierView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "MagnifierView.h"

@implementation MagnifierView
@synthesize viewToMagnify, touchPoint, overlayColor;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:CGRectMake(0, 0, 100, 100)]) {
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 8;
		self.layer.cornerRadius = 50;
		self.layer.masksToBounds = YES;
        overlayColor = [[UIView alloc] initWithFrame:self.frame];
        [overlayColor setAlpha:0];
        [self addSubview:overlayColor];
	}
	return self;
}

- (void)setTouchPoint:(CGPoint)pt {
	touchPoint = pt;
    UIColor *clr = [self colorAtPosition:touchPoint];
    self.layer.borderColor = [clr CGColor];
    [overlayColor setBackgroundColor:clr];
	self.center = CGPointMake(pt.x, pt.y-60);
}

- (void)changeAlpha:(CGFloat)num {
    [overlayColor setAlpha:num];
}

- (UIColor *)colorAtPosition:(CGPoint)position {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -position.x, -position.y);
    [self.viewToMagnify.layer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}

- (void) changeColor:(UIColor*) color {
    self.layer.borderColor = [color CGColor];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context,1*(self.frame.size.width*0.5),1*(self.frame.size.height*0.5));
	CGContextScaleCTM(context, 3, 3);
	CGContextTranslateCTM(context,-1*(touchPoint.x),-1*(touchPoint.y));
    [self.viewToMagnify drawViewHierarchyInRect:self.viewToMagnify.bounds afterScreenUpdates:YES];
}

@end
