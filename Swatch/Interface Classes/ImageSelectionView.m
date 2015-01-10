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
ColorDetailer *colorDetails;

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
    
    //COLOR DETAILS
    colorDetails = [[ColorDetailer alloc] init];

    
    
    [self addSubview:scrollView];
        [self addSubview:colorDetails];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.delegate = (id)self;
    longPress.minimumPressDuration=0.1;
    scrollView.userInteractionEnabled = YES;
    [scrollView addGestureRecognizer:longPress];
    
    
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


- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {
    NSLog(@"detected");
    CGPoint touchPoint=[sender locationInView:imageView];
    UIColor *clr = [self getRGBPixelColorAtPoint:touchPoint];
    if (clr != NULL) {
        [colorDetails changeColor:clr];
    }
    NSLog(@"%@", [self getRGBPixelColorAtPoint:touchPoint]);

}

- (UIColor*)getRGBPixelColorAtPoint:(CGPoint)point {
    UIColor* color = nil;
    CGImageRef cgImage = [imageView.image CGImage];
    size_t width = CGImageGetWidth(cgImage);
    size_t height = CGImageGetHeight(cgImage);
    NSUInteger x = (NSUInteger)floor(point.x);
    NSUInteger y = height - (NSUInteger)floor(point.y);
    
    if ((x < width) && (y < height)) {
        CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
        CFDataRef bitmapData = CGDataProviderCopyData(provider);
        const UInt8* data = CFDataGetBytePtr(bitmapData);
        size_t offset = ((width * y) + x) * 4;
        #if TARGET_IPHONE_SIMULATOR
        UInt8 red =   data[offset];
        UInt8 green = data[offset + 1];
        UInt8 blue =  data[offset + 2];
        #else
        //on device
        UInt8 blue =  data[offset];
        UInt8 green = data[offset + 1];
        UInt8 red =   data[offset + 2];
        #endif
        UInt8 alpha = data[offset+3];
        CFRelease(bitmapData);
        color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
    }
    
    return color;
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
