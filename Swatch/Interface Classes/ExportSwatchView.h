//
//  ExportSwatchView.h
//  Swatch
//
//  Created by Sony Theakanath on 1/15/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RalewayLabel.h"

@interface ExportSwatchView : UIView

- (id) init: (int)below;
- (void) setDetails: (UIColor*) color;

@property (nonatomic, retain) RalewayLabel *rgbValue;
@property (nonatomic, retain) RalewayLabel *hexValue;
@property (nonatomic, retain) UIColor *color;

@end
