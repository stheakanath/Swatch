//
//  SwatchTile.m
//  Swatch
//
//  Created by Sony Theakanath on 1/14/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "SwatchTile.h"

@implementation SwatchTile

@synthesize color;

-(id) init:(UIColor *)swatchColor offset:(int)set {
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setFrame:CGRectMake(set, 0, 50, 60)];
    [self setBackgroundColor:swatchColor];
    return self;
}

@end
