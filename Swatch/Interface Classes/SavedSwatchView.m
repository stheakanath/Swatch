//
//  SavedSwatchView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/14/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "SavedSwatchView.h"
#import "UIColorAdditions.h"

UIScrollView *scrollableSwatches;
NSMutableArray *colorArray;

@implementation SavedSwatchView

- (id) init {
    self = [super initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 80, [[UIScreen mainScreen] bounds].size.width, 80)];
    [self setBackgroundColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:49.0/255.0 alpha:1]];
    scrollableSwatches = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 60)];
    scrollableSwatches.userInteractionEnabled = YES;
    [self addSubview:scrollableSwatches];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *saveddata = [userDefaults objectForKey:@"colors"];
    colorArray = [self convertToUIColor:saveddata]; //convert this
    if(colorArray == nil)
        colorArray = [[NSMutableArray alloc] init];
    [self loadSwatches];
    return self;
}

- (void) loadSwatches {
    NSLog(@"%@", colorArray);
    int offset = 0;
    for (id color in [colorArray reverseObjectEnumerator]) {
        SwatchTile *swatch = [[SwatchTile alloc] init:color offset:offset];
        offset += 50;
        [scrollableSwatches addSubview:swatch];
    }
    scrollableSwatches.contentSize = CGSizeMake(offset, 60);
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
