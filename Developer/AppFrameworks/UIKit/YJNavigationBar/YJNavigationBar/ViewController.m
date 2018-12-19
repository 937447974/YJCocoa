//
//  ViewController.m
//  YJNavigationBar
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJUINavigationBar.h"
#import "YJSystemOther.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    if (self.navigationController.childViewControllers.count <= 2) {
        [self test1];
    } else {
        [self test2];
    }
}

- (void)test1 {
    @weakSelf
    YJUIBarButtonItem *item = [[YJUIBarButtonItem alloc] initWithTouchUpInsideBlock:^{
        @strongSelf
        [self.navigationController pushViewController:ViewController.new animated:YES];
    }];
    [item setTitle:@"跳转" font:nil color:nil highlightedColor:nil];
    self.navigationItem.rightBarButtonItem = item.buildBarButtonItem;
    YJUINavigationTitleView *titleView = [[YJUINavigationTitleView alloc] initWithFrame:CGRectZero];
    titleView.titleLabel.text = @"test1-YJUINavigationTitleView-YJUINavigationTitleView";
    self.navigationItem.titleView = titleView;
}

- (void)test2 {
    @weakSelf
    YJUIBarButtonItem *item = [[YJUIBarButtonItem alloc] initWithTouchUpInsideBlock:^{
        @strongSelf
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [item setImage:[UIImage imageNamed:@"nav_back"] highlightedImage:nil];
    self.navigationItem.leftBarButtonItem = item.buildBarButtonItem;
    
    YJUINavigationTitleView *titleView = [[YJUINavigationTitleView alloc] initWithFrame:CGRectZero];
    titleView.titleLabel.text = @"test2-YJUINavigationTitleView-YJUINavigationTitleView";
    self.navigationItem.titleView = titleView;
}

@end
