//
//  ViewController.m
//  YJViewGeometry
//
//  Created by admin on 16/5/31.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "UIView+YJUIViewGeometry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 50, 300, 300)];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(300, 600);
    scrollView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:view];
    [scrollView setContentOffset:CGPointMake(-100, -50) animated:NO];
    
    NSLog(@"%@", NSStringFromCGPoint(view.originFrameInWindow));
}

@end
