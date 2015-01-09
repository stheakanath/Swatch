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
    return self;
}

- (void) setImage:(UIImage *)image {
    imageView.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    scrollView.contentSize = imageView.frame.size;
    imageView.image = image;
}

- (void) setAlpha:(CGFloat)alpha {
    imageView.alpha = alpha;
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
     NSLog(@"%f", imageView.frame.size.width);
    NSLog(@"%f", imageView.frame.size.height);

    [self centerScrollViewContents];

}

@end
