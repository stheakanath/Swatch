//
//  SavedSwatchView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/14/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "SavedSwatchView.h"
#import "UIColorAdditions.h"
#import "ExportSwatchView.h"


UIView *viewContainingSwatches;
NSMutableArray *colorArray;

@implementation SavedSwatchView

@synthesize offset, scrollableSwatches, exportView;

- (id) init {
    self = [super initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-180, [[UIScreen mainScreen] bounds].size.width, 170)];
    [self setBackgroundColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:49.0/255.0 alpha:1]];
    scrollableSwatches = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, 60)];
    scrollableSwatches.userInteractionEnabled = YES;
    [scrollableSwatches setScrollEnabled:YES];
    [scrollableSwatches setDelegate:self];
    viewContainingSwatches = [[UIView alloc] initWithFrame:scrollableSwatches.frame];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *saveddata = [userDefaults objectForKey:@"colors"];
    colorArray = [self convertToUIColor:saveddata]; //convert this
    if(colorArray == nil)
        colorArray = [[NSMutableArray alloc] init];
    [self loadSwatches];
    [scrollableSwatches addSubview:viewContainingSwatches];
    [self addSubview:scrollableSwatches];
    exportView = [[ExportSwatchView alloc] init:80];
    [self addSubview:exportView];
    return self;
}

- (void) loadSwatches {
    offset = 0;
    for (id color in [colorArray reverseObjectEnumerator]) {
        SwatchTile *swatch = [[SwatchTile alloc] init:color offset:offset];
        offset += 50;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
        singleTap.numberOfTapsRequired = 1;
        [swatch addGestureRecognizer:singleTap];
        [viewContainingSwatches addSubview:swatch];
        [exportView setDetails:color];
    }
    viewContainingSwatches.frame = CGRectMake(0, 0, offset, 60);
    scrollableSwatches.contentSize = viewContainingSwatches.frame.size;
    [exportView setDetails:[colorArray lastObject]];
}

- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
    [exportView setDetails:((SwatchTile*)[recognizer view]).color];
}

- (void)addSwatch: (UIColor*)color {
    if (!(color == nil) && !([color isEqual:[colorArray lastObject]])) {
        [colorArray addObject:color];
        NSLog(@"%@", colorArray);
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[self convertToNSString:colorArray] forKey:@"colors"];
        [userDefaults synchronize];
        [self loadSwatches];
    }
}

- (NSMutableArray*)convertToUIColor: (NSArray*) arr {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSString* elem in arr) {
        [result addObject:[NSString colorFromNSString: elem]];
    }
    return result;
}

- (NSArray*)convertToNSString: (NSMutableArray*) arr {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (UIColor* elem in arr) {
        [result addObject:[UIColor stringFromUIColor: elem]];
    }
    return [NSArray arrayWithArray:result];
}

@end
