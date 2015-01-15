//
//  ImagePreviewButton.m
//  Swatch
//
//  Created by Sony Theakanath on 1/8/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ImagePreviewButton.h"

@implementation ImagePreviewButton

- (id) init:(NSString*)filename belowTop:(CGFloat)height {
    UIImage *def = [UIImage imageNamed:filename];
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setFrame:CGRectMake(height, 40, def.size.width, def.size.height)];
    [self setImage:def forState:UIControlStateNormal];
    return self;
}

@end
