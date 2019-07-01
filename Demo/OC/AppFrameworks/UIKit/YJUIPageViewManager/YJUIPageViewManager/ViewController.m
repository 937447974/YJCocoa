//
//  ViewController.m
//  YJUIPageViewManager
//
//  Created by admin on 2017/5/3.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJUIPageViewManager-Swift.h"
#import <YJCocoa/YJCocoa-Swift.h>

@interface ViewController ()

@property (nonatomic, strong) YJUIPageViewController *pageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self testClass];
}

- (void)initUI {
    self.pageView = [[YJUIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageView.view.frame = self.view.bounds;
    [self.view addSubview:self.pageView.view];
    [self addChildViewController:self.pageView];
}

- (void)testClass {
    self.pageView.manager.isDisableBounces = YES; // 关闭阻力效果
    // 填充数据源
    NSMutableArray *array = NSMutableArray.array;
    for (int i=0; i<5; i++) {
        [array addObject:[YJTestPageViewCell cellObject]];
    }
    self.pageView.dataSourceCell = array;
    [self.pageView reloadData];
}

@end
