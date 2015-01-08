//
//  ImageSelectionView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ImageSelectionView.h"

UIImageView *imagePreview;

@implementation ImageSelectionView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    imagePreview = [[UIImageView alloc] initWithFrame:frame];
    [imagePreview setImage:[UIImage imageNamed:@"selector_bg.jpg"]];
    [imagePreview setContentMode:UIViewContentModeScaleAspectFill];
    imagePreview.layer.masksToBounds = YES;
    [imagePreview setClipsToBounds:YES];
    [self addSubview:imagePreview];
    return self;
}

@end
