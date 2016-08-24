//
//  ViewController.m
//  YJViewGeometry
//
//  Created by admin on 16/5/31.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "UIView+YJTViewGeometry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 20, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    NSLog(@"%@", NSStringFromCGPoint(view.originFrameInWindow));
    view.centerXFrame = 100;
    NSLog(@"%@", NSStringFromCGRect(view.frame));
    
    self.view.topBounds = -130;
}

@end
