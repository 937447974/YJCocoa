//
//  ViewController.m
//  YJNavigationBar
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJUINavigationBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 修改默认配置
    [YJUINavigationBar appearance].titleColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    YJUIBarButtonView *shareBarButtonView = [YJUIBarButtonView appearance];
    shareBarButtonView.titleColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    // 显示
    YJUINavigationBar *nb = [[YJUINavigationBar alloc] initWithFrame:CGRectZero];
    nb.title = @"YJNavigationBar";
    // 框架按钮
    nb.leftBarButtonView.barButtonItem = [[YJUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] target:self action:@selector(onClickButton:)];
    // 自定义按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, YJUIBarButtonHeight)];
    button.titleLabel.font = [YJUIBarButtonView appearance].titleFont;
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:shareBarButtonView.titleColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
    nb.rightBarButtonView.barButton = button;
    self.navigationItem.titleView = nb;
}

- (void)onClickButton:(id)sender {
    NSLog(@"%@", sender);
}

@end
