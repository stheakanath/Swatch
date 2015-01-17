//
//  ExportSwatchView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/15/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ExportSwatchView.h"
#import "UIColorAdditions.h"
#import "ASEColorWriter.h"
#import "ViewController.h"

UIView *colorView;
UIButton *psdbutton;
UIButton *mailbutton;
RalewayLabel *empty;
ViewController *view;


@implementation ExportSwatchView

@synthesize hexValue, rgbValue, color;

- (id) init:(int)below {
    self = [super initWithFrame:CGRectMake(0, below, [[UIScreen mainScreen] bounds].size.width, 100)];
    colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
    [self addSubview:colorView];
    view = [ViewController new];
    
    rgbValue = [[RalewayLabel alloc] init: 0];
    [rgbValue setText:@"select a"];
    empty = [[RalewayLabel alloc] init: -30];
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
    [psdbutton setHidden:YES];
    [mailbutton setHidden:YES];
    return self;
}

- (void) setDetails:(UIColor*) rcolor{
    [psdbutton setHidden:NO];
    [mailbutton setHidden:NO];
    [empty removeFromSuperview];
    color = rcolor;
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

- (void) setNoSwatchesView {
    [empty setText:@"press and hold image"];
    [self addSubview:empty];
    [psdbutton setHidden:YES];
    [mailbutton setHidden:YES];
    [colorView setBackgroundColor:[UIColor clearColor]];
    [rgbValue setText:@"and tilt forward to add a"];
    [hexValue setText:@"{ swatch }"];
}

- (void) sendmail {
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    [mailViewController setSubject:@"{Swatch} - Swatch Data"];
    [mailViewController setMessageBody:[NSString stringWithFormat:@"{Swatch} Data - %@ %@", [rgbValue text], [hexValue text]] isHTML:YES];
    [self.delegate buttonTapped:mailViewController];
}

- (void) exportpsd {
    NSArray *colors = @[color];
    ASEColorWriter *writer = [[ASEColorWriter alloc] initWithColors:colors paletteName:@"Swatch Exported"];
    NSData *swatchData = [writer data];
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    [mailViewController setSubject:@"{Swatch} - ASE Export"];
    [mailViewController addAttachmentData:swatchData mimeType:@"application/octet-stream" fileName:@"swatches.ase"];
    [self.delegate buttonTapped:mailViewController];
}


@end
