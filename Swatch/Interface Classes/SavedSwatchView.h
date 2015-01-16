//
//  SavedSwatchView.h
//  Swatch
//
//  Created by Sony Theakanath on 1/14/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwatchTile.h"
#import "ExportSwatchView.h"

@interface SavedSwatchView : UIView <UIScrollViewDelegate>

- (id)init;
- (void)addSwatch: (UIColor*)color;

@property (nonatomic) int offset;
@property (nonatomic, strong) UIScrollView *scrollableSwatches;
@property (nonatomic, strong) ExportSwatchView *exportView;
@end
