//
//  ViewController.m
//  YJNavigationBar
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJCNavigationBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 修改默认配置
    [YJCNavigationBar appearance].titleColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    [YJCBarButtonView appearance].titleColor = [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
    
    // 显示
    YJCNavigationBar *nb = [[YJCNavigationBar alloc] initWithFrame:CGRectZero];
    nb.title = @"YJNavigationBar";
    nb.leftBarButtonView.barButtonItem = [[YJCBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] target:self action:@selector(onClickButton:)];
    nb.rightBarButtonView.barButtonItem = [[YJCBarButtonItem alloc] initWithTitle:@"完成" target:self action:@selector(onClickButton:)];
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
