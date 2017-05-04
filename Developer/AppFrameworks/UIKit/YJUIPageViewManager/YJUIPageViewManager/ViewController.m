//
//  ViewController.m
//  YJUIPageViewManager
//
//  Created by admin on 2017/5/3.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJUIPageViewManager.h"

#import "YJUIPageViewTestCell.h"
#import "YJUIPageViewTestCell2.h"

@interface ViewController ()

@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, strong) YJUIPageViewManager *pageViewManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testXib];
    [self testClass];
}

- (void)testXib {
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageVC.view.frame = self.view.bounds;
    [self.view addSubview:self.pageVC.view];
    [self addChildViewController:self.pageVC];
    self.pageViewManager = [[YJUIPageViewManager alloc] initWithPageViewController:self.pageVC];
    
    self.pageViewManager.timeInterval = 1;
    // 填充数据源
    for (int i=0; i<5; i++) {
        [self.pageViewManager.dataSource addObject:[YJUIPageViewTestCell cellObjectWithCellModel:nil]];
    }
    [self.pageViewManager reloadPage];
}

- (void)testClass {
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageVC.view.frame = self.view.bounds;
    [self.view addSubview:self.pageVC.view];
    [self addChildViewController:self.pageVC];
    self.pageViewManager = [[YJUIPageViewManager alloc] initWithPageViewController:self.pageVC];
    
    self.pageViewManager.isDisableBounces = YES; // 关闭阻力效果
    // 填充数据源
    for (int i=0; i<5; i++) {
        [self.pageViewManager.dataSource addObject:[YJUIPageViewTestCell2 cellObjectWithCellModel:nil]];
    }
    [self.pageViewManager reloadPage];
}


@end
