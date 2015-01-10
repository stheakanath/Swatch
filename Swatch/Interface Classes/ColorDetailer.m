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
    self = [super initWithFrame:CGRectMake(0, 0, 60, 60)];
    [self setBackgroundColor:[UIColor blackColor]];
    self.layer.shadowOffset = CGSizeMake(0, 10);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    
    UIImage *_maskingImage = [UIImage imageNamed:@"Color.png"];
    CALayer *_maskingLayer = [CALayer layer];
    _maskingLayer.frame = self.bounds;
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [self.layer setMask:_maskingLayer];
    return self;
}

- (void) changeColor:(UIColor*) color location:(CGPoint)point{
    [self setFrame:CGRectMake(point.x-40, point.y-70, 60, 60)];
    [self setBackgroundColor:color];
}

@end
