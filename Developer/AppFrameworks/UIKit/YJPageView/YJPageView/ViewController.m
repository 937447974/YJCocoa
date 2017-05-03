//
//  ViewController.m
//  YJUIPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJUIPageView
//
//  Created by 阳君 on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"

#import "YJUIImagePageViewController.h"
#import "YJUIPageView.h"
#import "YJAutoLayout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {    
    [super viewDidLoad];
    [self test];
//    [self testPressure];
}

- (void)test {
    // 初始化
    YJUIPageView *pageView = [[YJUIPageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:pageView];
    pageView.boundsLayoutTo(self.view);
    
    // 修改UIPageViewController
    [pageView initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    pageView.isLoop = YES;
//    pageView.isDisableBounces = YES;
    pageView.timeInterval = 0.5;
//    pageView.isTimeLoopAnimatedStop = YES;
    // 填充数据源
    for (int i=0; i<5; i++) {
        YJUIImagePageModel *model = [[YJUIImagePageModel alloc] init];
        model.imageNamed = @"LaunchImage";
        model.isOnClick = YES;
        [pageView.dataSource addObject:[YJUIImagePageViewController cellObjectWithCellModel:model]];
    }
    [pageView reloadPage];
}

#pragma mark 压力测试
- (void)testPressure {
    // 初始化
    YJUIPageView *pageView = [[YJUIPageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:pageView];
    pageView.boundsLayoutTo(self.view);
    pageView.isLoop = YES;
    pageView.timeInterval = 0.01; // 峰值，内存释放稳定
    // 填充数据源100个
    for (int i=0; i<100; i++) {
        YJUIImagePageModel *model = [[YJUIImagePageModel alloc] init];
        model.imageNamed = @"LaunchImage";
        [pageView.dataSource addObject:[YJUIImagePageViewController cellObjectWithCellModel:model]];
    }
    [pageView reloadPage];
}

@end
