//
//  ViewController.h
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageSelectionView.h"
#import "ImagePreviewButton.h"
#import "SavedSwatchView.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate>

@end

