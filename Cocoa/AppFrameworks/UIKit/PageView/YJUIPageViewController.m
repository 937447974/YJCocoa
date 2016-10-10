//
//  YJUIPageViewController.m
//  YJUIPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUIPageViewController.h"
#import "YJUIPageViewObject.h"
#import "YJUIPageView.h"
#import "YJDispatch.h"

@interface YJUIPageViewController ()

@end

@implementation YJUIPageViewController

#pragma mark - (+)
+ (YJUIPageViewObject *)pageViewObject {
    return [[YJUIPageViewObject alloc] initWithPageClass:[self class]];
}

#pragma mark - super
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.pageView.pageViewAppear(self, YJUIPageViewAppearWill);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.pageView.pageViewAppear(self, YJUIPageViewAppearDid);
}

#pragma mark - 刷新界面
- (void)reloadDataWithPageViewObject:(YJUIPageViewObject *)pageViewObject pageView:(YJUIPageView *)pageView {
    [self reloadDataSyncWithPageViewObject:pageViewObject pageView:pageView];
    __weak YJUIPageViewController *weakSelf = self;
    dispatch_async_main(^{
        [weakSelf reloadDataAsyncWithPageViewObject:weakSelf.pageViewObject pageView:weakSelf.pageView];
    });
}

- (void)reloadDataSyncWithPageViewObject:(YJUIPageViewObject *)pageViewObject pageView:(YJUIPageView *)pageView {
    _pageViewObject = pageViewObject;
    _pageView = pageView;
}

- (void)reloadDataAsyncWithPageViewObject:(YJUIPageViewObject *)pageViewObject pageView:(YJUIPageView *)pageView {
   
}

@end
