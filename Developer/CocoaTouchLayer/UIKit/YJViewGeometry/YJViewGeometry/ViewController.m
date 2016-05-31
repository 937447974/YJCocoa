//
//  ViewController.m
//  YJViewGeometry
//
//  Created by admin on 16/5/31.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "UIView+YJViewGeometry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 100, 100)];
    [self.view addSubview:view];
    NSLog(@"%@", NSStringFromCGPoint(view.originFrameInWindow));
    view.centerXFrame = 10;
    NSLog(@"%@", NSStringFromCGRect(view.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
