//
//  ImageSelectionView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ImageSelectionView.h"
#import <QuartzCore/QuartzCore.h>

UIScrollView *scrollView;
UIImageView *imageView;
ColorDetailer *colorDetails;

@implementation ImageSelectionView

- (id)init {
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //ScrollView, ImageView, colordetails set up
    scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [scrollView setBackgroundColor:[UIColor grayColor]];
    [scrollView setDelegate:self];
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selector_bg.jpg"]];
    scrollView.contentSize = imageView.frame.size;
    [scrollView addSubview:imageView];
    scrollView.minimumZoomScale = scrollView.frame.size.width / imageView.frame.size.width;
    scrollView.maximumZoomScale = 2.0;
    [scrollView setZoomScale:scrollView.minimumZoomScale];
    colorDetails = [[ColorDetailer alloc] init];
    
    //Gesture Recognizer for colorDetails
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.delegate = (id)self;
    longPress.minimumPressDuration=0.1;
    scrollView.userInteractionEnabled = YES;
    [scrollView addGestureRecognizer:longPress];
    [self addSubview:scrollView];
    [self addSubview:colorDetails];
    return self;
}

# pragma mark - Color Selection Functions

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {
    CGPoint touchPoint=[sender locationInView:imageView];
    UIColor *clr = [self colorAtPosition:touchPoint];
    if (clr != NULL)
        [colorDetails changeColor:clr];
}

- (UIColor *)colorAtPosition:(CGPoint)position {
    CGRect sourceRect = CGRectMake(position.x, position.y, 1.f, 1.f);
    CGImageRef imageRef = CGImageCreateWithImageInRect(imageView.image.CGImage, sourceRect);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *buffer = malloc(4);
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
    CGContextRef context = CGBitmapContextCreate(buffer, 1, 1, 8, 4, colorSpace, bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0.f, 0.f, 1.f, 1.f), imageRef);
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGFloat r = buffer[0] / 255.f;
    CGFloat g = buffer[1] / 255.f;
    CGFloat b = buffer[2] / 255.f;
    CGFloat a = buffer[3] / 255.f;
    free(buffer);
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

# pragma mark - Self Delegation Functions

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
    [self centerScrollViewContents];
}

@end