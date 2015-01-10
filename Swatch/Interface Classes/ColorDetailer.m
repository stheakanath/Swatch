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
    return self;
}

- (void) changeColor:(UIColor*) color {
    [self setBackgroundColor:color];
}

@end
