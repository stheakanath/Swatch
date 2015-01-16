//
//  ImageSelectionView.h
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "MagnifierView.h"
#import "SavedSwatchView.h"

@interface ImageSelectionView : UIView <UIScrollViewDelegate> {
    NSTimer *touchTimer;
    MagnifierView *loop;
    CMMotionManager *motionManager;
    CADisplayLink *motionDisplayLink;
    double startPitch;
}

@property (nonatomic, retain) NSTimer *touchTimer;
@property (nonatomic, strong) SavedSwatchView *savedswatches;

- (void)addLoop;
- (void)handleAction:(id)timerObj;
- (id)init;
- (void)setImage:(UIImage*)image;
- (void)setAlpha:(CGFloat)alpha;

@end
