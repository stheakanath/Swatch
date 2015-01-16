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
BOOL changing;

@implementation ImageSelectionView

@synthesize touchTimer, savedswatches;

- (id)init {
    self = [super initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 10)];
    
    //ScrollView, ImageView, colordetails set up
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-190)];
    
    //[scrollView setBackgroundColor:[UIColor colorWithRed:149/255.0 green:165/255.0 blue:166/255.0 alpha:1]];
    [scrollView setBackgroundColor:[UIColor darkGrayColor]];
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
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 0.02;
    motionDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(motionRefresh:)];
    [motionDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    if ([motionManager isDeviceMotionAvailable])
        [motionManager startDeviceMotionUpdatesUsingReferenceFrame: CMAttitudeReferenceFrameXArbitraryZVertical];
    
    savedswatches = [[SavedSwatchView alloc] init];
    [self addSubview:savedswatches];
    return self;
}

# pragma mark - UIAccelerometer Delegation

- (void)motionRefresh:(id)sender {
    double change = startPitch - motionManager.deviceMotion.attitude.pitch;
    if (change > .2) {
        NSLog(@"Swatch Added!");
        [savedswatches addSwatch:loop.overlayColor.backgroundColor];
        startPitch = 0;
    }
    double scaled = change / 0.2;
    [loop changeAlpha:scaled];
}

# pragma mark - Color Selection Functions

- (void)handleTapFrom:(UILongPressGestureRecognizer *)recognizer {
    if ([recognizer state] == UIGestureRecognizerStateEnded) {
        [self.touchTimer invalidate];
        self.touchTimer = nil;
        [loop removeFromSuperview];
    } else if ([recognizer state] == UIGestureRecognizerStateBegan) {
        startPitch = motionManager.deviceMotion.attitude.pitch;
        
        NSLog(@"%f", startPitch);
        self.touchTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addLoop) userInfo:nil repeats:NO];
        if(loop == nil){
            loop = [[MagnifierView alloc] init];
            loop.viewToMagnify = self;
        }
        loop.touchPoint = [recognizer locationInView:self];
        [loop setNeedsDisplay];
    } else if ([recognizer state] == UIGestureRecognizerStateChanged) {
        startPitch = motionManager.deviceMotion.attitude.pitch;
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