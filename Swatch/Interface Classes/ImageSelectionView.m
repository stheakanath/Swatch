//
//  ImageSelectionView.m
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ImageSelectionView.h"
#import <QuartzCore/QuartzCore.h>
#import "MagnifierView.h"

UIScrollView *scrollView;
UIImageView *imageView;
BOOL holding;

@implementation ImageSelectionView

@synthesize touchTimer;

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
    
    //Gesture Recognizer for colorDetails
    UILongPressGestureRecognizer *tapGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    tapGestureRecognizer.minimumPressDuration=0.1;
    tapGestureRecognizer.delegate = (id)self;
    [scrollView addGestureRecognizer:tapGestureRecognizer];
    scrollView.userInteractionEnabled = YES;
    [self addSubview:scrollView];
    return self;
}

# pragma mark - Color Selection Functions

/*- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        holding = FALSE;
    }
    if (!holding) {
        if (sender.state == UIGestureRecognizerStateBegan) {
            holding = TRUE;
            [colorDetails animateBringIn:1];
            CGPoint touchPoint=[sender locationInView:imageView];
            UIColor *clr = [self colorAtPosition:touchPoint];
            if (clr != NULL)
                [colorDetails changeColor:clr location:[sender locationInView:self]];
        } else if (sender.state == UIGestureRecognizerStateEnded) {
            [colorDetails animateBringIn:0];
            holding = FALSE;
        }
    } else {
        [colorDetails animateBringIn:1];
        CGPoint touchPoint=[sender locationInView:imageView];
        UIColor *clr = [self colorAtPosition:touchPoint];
        if (clr != NULL)
            [colorDetails changeColor:clr location:[sender locationInView:self]];
    }
} */

- (void)handleTapFrom:(UILongPressGestureRecognizer *)recognizer {
    if ([recognizer state] == UIGestureRecognizerStateEnded) {
        [self.touchTimer invalidate];
        self.touchTimer = nil;
        [loop removeFromSuperview];
    } else if ([recognizer state] == UIGestureRecognizerStateBegan) {
        self.touchTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addLoop) userInfo:nil repeats:NO];
        if(loop == nil){
            loop = [[MagnifierView alloc] init];
            loop.viewToMagnify = self;
        }
        loop.touchPoint = [recognizer locationInView:self];
        [loop setNeedsDisplay];
    } else if ([recognizer state] == UIGestureRecognizerStateChanged) {
        [self handleAction:recognizer];
    }
}

- (void)addLoop {
    [self.superview addSubview:loop];
}

- (void)handleAction:(UILongPressGestureRecognizer*)touch {
    loop.touchPoint = [touch locationInView:self];
    [loop setNeedsDisplay];
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