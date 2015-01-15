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
	if (self = [super initWithFrame:CGRectMake(0, 0, 80, 80)]) {
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 5;
		self.layer.cornerRadius = 40;
		self.layer.masksToBounds = YES;
	}
	return self;
}

- (void)setTouchPoint:(CGPoint)pt {
	touchPoint = pt;
	self.center = CGPointMake(pt.x, pt.y-60);
}

- (void) changeColor:(UIColor*) color {
    self.layer.borderColor = [color CGColor];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context,1*(self.frame.size.width*0.5),1*(self.frame.size.height*0.5));
	CGContextScaleCTM(context, 3, 3);
	CGContextTranslateCTM(context,-1*(touchPoint.x),-1*(touchPoint.y));
	[self.viewToMagnify.layer renderInContext:context];
}

@end
