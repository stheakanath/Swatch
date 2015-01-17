//
//  ExportSwatchView.h
//  Swatch
//
//  Created by Sony Theakanath on 1/15/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RalewayLabel.h"
#import <MessageUI/MFMailComposeViewController.h>

@protocol ExportSwatchViewDelegate <NSObject>

- (void)buttonTapped:(MFMailComposeViewController*)controller;

@end


@interface ExportSwatchView : UIView

- (id) init: (int)below;
- (void) setDetails: (UIColor*) color;
- (void) setNoSwatchesView;

@property (nonatomic, retain) RalewayLabel *rgbValue;
@property (nonatomic, retain) RalewayLabel *hexValue;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, strong) id<ExportSwatchViewDelegate> delegate;

@end
