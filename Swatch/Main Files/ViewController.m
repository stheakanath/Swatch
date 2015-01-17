//
//  ViewController.m
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ViewController.h"
#import "ExportSwatchView.h"

@interface ViewController ()<ExportSwatchViewDelegate>

@property (nonatomic, strong) ImagePreviewButton *closebutton;
@property (nonatomic, strong) ImagePreviewButton *photobutton;
@property (nonatomic, strong) ImageSelectionView *topcontroller;

@end

ExportSwatchView *view;

@implementation ViewController

#pragma mark - MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)buttonTapped:(MFMailComposeViewController*)controller {
    controller.mailComposeDelegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topcontroller = [[ImageSelectionView alloc] init];
    [self.view setBackgroundColor:[UIColor colorWithRed:33.0/255.0 green:39.0/255.0 blue:49.0/255.0 alpha:1]];
    [self.view addSubview:self.topcontroller];
    //Buttons
    self.closebutton = [[ImagePreviewButton alloc] init:@"closeicon.png" belowTop:20];
    [self.closebutton addTarget:self action:@selector(cancelImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closebutton];

    self.photobutton = [[ImagePreviewButton alloc] init:@"photoicon.png" belowTop:[[UIScreen mainScreen] bounds].size.width-60];
    [self.photobutton addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.photobutton];
    view = self.topcontroller.savedswatches.exportView;
    view.delegate = self;
}


# pragma mark - CustomButton Functions

- (IBAction)cancelImage:(id)sender {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.topcontroller setAlpha:0];
    } completion:^ (BOOL finished) {
        [self.topcontroller setAlpha:1];
        [self.topcontroller setImage:nil];
    }];
}

- (IBAction)addImage:(id)sender {
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickController.delegate = self;
    imagePickController.allowsEditing = TRUE;
    [self presentViewController:imagePickController animated:YES completion:nil];
}

# pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    [self.topcontroller setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
