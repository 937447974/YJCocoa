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
    [YJUIBarButtonView appearance].titleColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    // 显示
    YJUINavigationBar *nb = [[YJUINavigationBar alloc] initWithFrame:CGRectZero];
    nb.title = @"YJNavigationBar";
    nb.leftBarButtonView.barButtonItem = [[YJUIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] target:self action:@selector(onClickButton:)];
    nb.rightBarButtonView.barButtonItem = [[YJUIBarButtonItem alloc] initWithTitle:@"完成" target:self action:@selector(onClickButton:)];
    self.navigationItem.titleView = nb;
    
}

- (void)onClickButton:(id)sender {
    NSLog(@"%@", sender);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
