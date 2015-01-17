//
//  ExportSwatchView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/15/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ExportSwatchView.h"
#import "UIColorAdditions.h"

UIView *colorView;
UIButton *psdbutton;
UIButton *mailbutton;

@implementation ExportSwatchView

@synthesize hexValue, rgbValue, color;

- (id) init:(int)below {
    self = [super initWithFrame:CGRectMake(0, below, [[UIScreen mainScreen] bounds].size.width, 100)];
    colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
    [self addSubview:colorView];
    rgbValue = [[RalewayLabel alloc] init: 0];
    [rgbValue setText:@"select a"];
    hexValue = [[RalewayLabel alloc] init: 30];
    [hexValue setText:@"{ swatch }"];
    [self addSubview:rgbValue];
    [self addSubview:hexValue];
    psdbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [psdbutton setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/5 - 35, 15, 40, 54)];
    [psdbutton setImage:[UIImage imageNamed:@"psd_light.png"] forState:UIControlStateNormal];
    [psdbutton addTarget:self action:@selector(exportpsd) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:psdbutton];
    mailbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mailbutton setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2 + 90, 22, 52, 36)];
    [mailbutton setImage:[UIImage imageNamed:@"mail_light.png"] forState:UIControlStateNormal];
    [mailbutton addTarget:self action:@selector(sendmail) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mailbutton];
    return self;
}

- (void) setDetails:(UIColor*) rcolor{
    [colorView setBackgroundColor:rcolor];
    [rgbValue setText:[NSString cleanStringFromUIColor: rcolor]];
    [hexValue setText:[NSString hexStringForColor:rcolor]];
    if ([NSString totalvalue:rcolor] > 378) {
        [mailbutton setImage:[UIImage imageNamed:@"mail_dark.png"] forState:UIControlStateNormal];
        [psdbutton setImage:[UIImage imageNamed:@"psd_dark.png"] forState:UIControlStateNormal];
        [rgbValue setTextColor:[UIColor blackColor]];
        [hexValue setTextColor:[UIColor blackColor]];
    } else {
        [psdbutton setImage:[UIImage imageNamed:@"psd_light.png"] forState:UIControlStateNormal];
        [mailbutton setImage:[UIImage imageNamed:@"mail_light.png"] forState:UIControlStateNormal];
        [rgbValue setTextColor:[UIColor whiteColor]];
        [hexValue setTextColor:[UIColor whiteColor]];
    }
}

- (void) sendmail {
    NSString *recipients = @"mailto:sendto@domain.com&subject=Swatch Export";
    NSString *body = [NSString stringWithFormat:@"&body=%@ %@", [rgbValue text], [hexValue text]];
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

- (void) exportpsd {
    NSString *recipients = @"mailto:sendto@domain.com&subject=Swatch Export";
    NSString *body = [NSString stringWithFormat:@"&body=%@ %@", [rgbValue text], [hexValue text]];
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}


@end
