//
//  MagnifierView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "MagnifierView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MagnifierView
@synthesize viewToMagnify, touchPoint;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:CGRectMake(0, 0, 100, 100)]) {
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 8;
		self.layer.cornerRadius = 50;
		self.layer.masksToBounds = YES;
	}
	return self;
}

- (void)setTouchPoint:(CGPoint)pt {
	touchPoint = pt;
   self.layer.borderColor = [[self colorAtPosition:touchPoint] CGColor];
	self.center = CGPointMake(pt.x, pt.y-60);
}

- (UIColor *)colorAtPosition:(CGPoint)position {
   CGRect sourceRect = CGRectMake(position.x, position.y, 1.f, 1.f);
    UIGraphicsBeginImageContextWithOptions(viewToMagnify.bounds.size, viewToMagnify.opaque, viewToMagnify.contentScaleFactor);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.viewToMagnify drawViewHierarchyInRect:self.viewToMagnify.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, sourceRect);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *buffer = malloc(4);
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
    context = CGBitmapContextCreate(buffer, 1, 1, 8, 4, colorSpace, bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0.f, 0.f, 1.f, 1.f), imageRef);
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGFloat r = buffer[0] / 255.f;
    CGFloat g = buffer[1] / 255.f;
    CGFloat b = buffer[2] / 255.f;
    CGFloat a = buffer[3] / 255.f;
    free(buffer);
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
    
   /* unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color; */
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
