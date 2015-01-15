//
//  SavedSwatchView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/14/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "SavedSwatchView.h"

UIScrollView *scrollableSwatches;

@implementation SavedSwatchView

- (id) init {
    self = [super initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 80, [[UIScreen mainScreen] bounds].size.width, 80)];
    [self setBackgroundColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:49.0/255.0 alpha:1]];
    scrollableSwatches = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, 60)];
    scrollableSwatches.userInteractionEnabled = YES;

    [self addSubview:scrollableSwatches];

    
    [self loadSwatches];
    return self;
}

- (void) loadSwatches {
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableArray *colorArray =[[NSMutableArray alloc] initWithObjects:[UIColor blueColor], [UIColor whiteColor], nil];
    int offset = 0;
    for (id color in colorArray) {
        SwatchTile *swatch = [[SwatchTile alloc] init:color offset:offset];
        offset += 50;
        [scrollableSwatches addSubview:swatch];
    }
    scrollableSwatches.contentSize = CGSizeMake(offset, 60);
}

@end
