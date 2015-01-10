//
//  ColorDetailer.m
//  Swatch
//
//  Created by Sony Theakanath on 1/9/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ColorDetailer.h"

@implementation ColorDetailer

- (id) init {
    self = [super initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self setBackgroundColor:[UIColor blackColor]];
    self.layer.shadowOffset = CGSizeMake(0, 10);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    return self;
}

- (void) changeColor:(UIColor*) color location:(CGPoint)point{
    NSLog(@"%@", NSStringFromCGPoint(point));
    [self setFrame:CGRectMake(point.x-20, point.y-60, 40, 40)];
    [self setBackgroundColor:color];
}

@end
