//
//  ViewController.m
//  Swatch
//
//  Created by Sony Theakanath on 1/7/15.
//  Copyright (c) 2015 Sony Theakanath. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, strong) ImageSelectionView *topcontroller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.topcontroller = [[ImageSelectionView alloc] initWithFrame:CGRectMake(5, 30, screenRect.size.width - 20, screenRect.size.height - 200)];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:self.topcontroller];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
