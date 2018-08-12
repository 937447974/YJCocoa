//
//  ViewController.m
//  YJUIPageViewManager
//
//  Created by admin on 2017/5/3.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJUIPageViewController.h"

#import "YJUIPageViewTestCell.h"
#import "YJUIPageViewTestCell2.h"

@interface ViewController () <YJUIPageViewControllerDelegate>

@property (nonatomic, strong) YJUIPageViewController *pageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
//    [self testXib];
    [self testClass];
}

- (void)initUI {
    self.pageView = [[YJUIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageView.view.frame = self.view.bounds;
    [self.view addSubview:self.pageView.view];
    [self addChildViewController:self.pageView];
}

- (void)testXib {
//    self.pageView.manager.timeInterval = 1;
    // 填充数据源
    for (int i=0; i<5; i++) {
        [self.pageView.dataSourcePlain addObject:[YJUIPageViewTestCell cellObjectWithCellModel:nil]];
    }
    [self.pageView reloadData];
}

- (void)testClass {
    self.pageView.manager.isDisableBounces = YES; // 关闭阻力效果
    // 填充数据源
    for (int i=0; i<5; i++) {
        [self.pageView.dataSourcePlain addObject:[YJUIPageViewTestCell2 cellObjectWithCellModel:nil]];
    }
    [self.pageView reloadData];
    self.pageView.pageDelegate = self;
}

#pragma mark - YJUIPageViewControllerDelegate
- (void)pageViewController:(YJUIPageViewController *)controller didScrolloffset:(CGFloat)offset {
    NSLog(@"%f", offset);
}


@end
