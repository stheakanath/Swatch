//
//  MagnifierView.h
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MagnifierView : UIView {
	UIView *viewToMagnify;
	CGPoint touchPoint;
    UIView *overlayColor;
}

@property (nonatomic, retain) UIView *viewToMagnify;
@property (nonatomic, retain) UIView *overlayColor;
@property (nonatomic, assign) CGPoint touchPoint;

- (void)changeAlpha:(CGFloat)num;
@end
