//
//  YJPageViewController.m
//  YJPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJPageViewController.h"
#import "YJPageViewObject.h"
#import "YJPageView.h"

@interface YJPageViewController ()

@end

@implementation YJPageViewController

#pragma mark - (+)
+ (YJPageViewObject *)pageViewObject {
    return [[YJPageViewObject alloc] initWithPageClass:[self class]];
}

#pragma mark - super
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.pageView.pageViewAppear(self, YJPageViewAppearWill);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.pageView.pageViewAppear(self, YJPageViewAppearDid);
}

#pragma mark - 刷新界面
- (void)reloadDataSyncWithPageViewObject:(YJPageViewObject *)pageViewObject pageView:(YJPageView *)pageView {
    _pageViewObject = pageViewObject;
    _pageView = pageView;
}

- (void)reloadDataAsyncWithPageViewObject:(YJPageViewObject *)pageViewObject pageView:(YJPageView *)pageView {
    _pageViewObject = pageViewObject;
    _pageView = pageView;
}

@end
