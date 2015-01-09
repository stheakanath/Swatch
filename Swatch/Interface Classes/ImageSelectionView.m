//
//  ImageSelectionView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ImageSelectionView.h"

UIScrollView *scrollView;
UIImageView *imageView;
UIButton *closebutton;
UIButton *photobutton;

@implementation ImageSelectionView

- (id)init {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //ScrollView and ImageView set up
    scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [scrollView setBackgroundColor:[UIColor grayColor]];
    [scrollView setDelegate:self];
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selector_bg.jpg"]];
    scrollView.contentSize = imageView.frame.size;
    [scrollView addSubview:imageView];
    scrollView.minimumZoomScale = scrollView.frame.size.width / imageView.frame.size.width;
    scrollView.maximumZoomScale = 2.0;
    [scrollView setZoomScale:scrollView.minimumZoomScale];
    [self addSubview:scrollView];
    
    //Setting up cancel and photo buttons
    UIImage *closeimage = [UIImage imageNamed:@"closeicon.png"];
    closebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closebutton setFrame:CGRectMake(20, 40, closeimage.size.width, closeimage.size.height)];
    [closebutton setImage:closeimage forState:UIControlStateNormal];
    [self addSubview:closebutton];
    
    UIImage *photoimage = [UIImage imageNamed:@"photoicon.png"];
    photobutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photobutton setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-60, 40, photoimage.size.width, photoimage.size.height)];
    [photobutton setImage:photoimage forState:UIControlStateNormal];
    [self addSubview:photobutton];
    
    return self;
}

# pragma mark - UIScrollView Delegation

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

- (void)centerScrollViewContents {
    CGSize boundsSize = scrollView.bounds.size;
    CGRect contentsFrame = imageView.frame;
    if (contentsFrame.size.width < boundsSize.width)
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    else
        contentsFrame.origin.x = 0.0f;
    if (contentsFrame.size.height < boundsSize.height)
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    else
        contentsFrame.origin.y = 0.0f;
    imageView.frame = contentsFrame;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollViewContents];
}

@end
