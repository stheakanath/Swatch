//
//  SwatchTile.m
//  Swatch
//
//  Created by Sony Theakanath on 1/14/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "SwatchTile.h"
#import "SavedSwatchView.h"

@implementation SwatchTile

@synthesize color;

-(id) init:(UIColor *)swatchColor offset:(int)set {
    self = [super initWithFrame:CGRectMake(set, 0, 50, 60)];
    color = swatchColor;
    [self setBackgroundColor:swatchColor];
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    SavedSwatchView *test = [SavedSwatchView alloc];
    [test.exportView setDetails:color];
}

@end
