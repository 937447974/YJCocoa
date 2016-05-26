//
//  ViewController.m
//  YJPageView
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974
//  HomePage:https://github.com/937447974/YJPageView
//
//  Created by 阳君 on 16/4/27.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"

#import "YJImagePageViewController.h"
#import "YJPageView.h"
#import "YJAutoLayout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {    
    [super viewDidLoad];
//    [self test];
    [self testPressure];
}

- (void)test {
    // 初始化
    YJPageView *pageView = [[YJPageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:pageView];
    pageView.boundsLayoutTo(self.view);
    
    // 启用UIPageControl
    pageView.pageControl.widthLayout.equalToConstant(100);
    pageView.pageControl.heightLayout.equalToConstant(30);
    pageView.pageControl.centerLayoutTo(self.view);
    pageView.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    
    // 修改UIPageViewController
    [pageView initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    pageView.isLoop = YES;
//    pageView.isDisableBounces = YES;
    pageView.timeInterval = 0.5;
//    pageView.isTimeLoopAnimatedStop = YES;
    // 监听
    pageView.pageViewAppear = ^(YJPageViewController *pageVC, YJPageViewAppear appear) {
        switch (appear) {
            case YJPageViewAppearWill: {
                NSLog(@"Will：%ld", (long)pageVC.pageViewObject.pageIndex);
                break;
            }
            case YJPageViewAppearDid:
                NSLog(@"Did：%ld", (long)pageVC.pageViewObject.pageIndex);
                break;
        }
    };
    pageView.pageViewDidSelect = ^(YJPageViewController *pageVC) {
        NSLog(@"点击：%ld", (long)pageVC.pageViewObject.pageIndex);
    };
    // 填充数据源
    for (int i=0; i<5; i++) {
        YJPageViewObject *obj = [YJImagePageViewController pageViewObject];
        YJImagePageModel *model = [[YJImagePageModel alloc] init];
        model.imageNamed = @"LaunchImage";
        model.isOnClick = YES;
        obj.pageModel = model;
        [pageView.dataSource addObject:obj];
    }
    [pageView reloadPage];
}

#pragma mark 压力测试
- (void)testPressure {
    // 初始化
    YJPageView *pageView = [[YJPageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:pageView];
    pageView.boundsLayoutTo(self.view);
    pageView.isLoop = YES;
    pageView.timeInterval = 0.02; // 峰值，内存释放稳定
    // 填充数据源100个
    for (int i=0; i<100; i++) {
        YJPageViewObject *obj = [YJImagePageViewController pageViewObject];
        YJImagePageModel *model = [[YJImagePageModel alloc] init];
        model.imageNamed = @"LaunchImage";
        obj.pageModel = model;
        [pageView.dataSource addObject:obj];
    }
    [pageView reloadPage];
}

@end
