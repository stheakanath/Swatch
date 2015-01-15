//
//  SwatchTile.h
//  Swatch
//
//  Created by Sony Theakanath on 1/14/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwatchTile : UIButton

@property (nonatomic, retain) UIColor *color;

-(id) init:(UIColor*)swatchColor offset:(int)set;

@end
