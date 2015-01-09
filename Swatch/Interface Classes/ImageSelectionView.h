//
//  ImageSelectionView.h
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePreviewButton.h"

@interface ImageSelectionView : UIView <UIScrollViewDelegate>

- (id)init;
- (void)setImage:(UIImage*)image;
- (void)setAlpha:(CGFloat)alpha;

@end
