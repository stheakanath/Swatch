//
//  RalewayLabel.m
//  Swatch
//
//  Created by Sony Theakanath on 1/15/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "RalewayLabel.h"

@implementation RalewayLabel

-(id) init:(int) below {
    self = [super initWithFrame:CGRectMake(0, below, [[UIScreen mainScreen] bounds].size.width, 50)];
    [self setFont:[UIFont fontWithName:@"Raleway-ExtraLight" size:22]];
    [self setShadowOffset:CGSizeMake(0.5, 0)];
    [self setTextColor:[UIColor whiteColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setTextAlignment:NSTextAlignmentCenter];
    return self;
}

@end
