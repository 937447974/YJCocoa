//
//  YJTPageViewController.m
//  YJTPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/3.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTPageViewController.h"
#import "YJTPageViewObject.h"
#import "YJTPageView.h"
#import "YJCSystem.h"

@interface YJTPageViewController ()

@end

@implementation YJTPageViewController

#pragma mark - (+)
+ (YJTPageViewObject *)pageViewObject {
    return [[YJTPageViewObject alloc] initWithPageClass:[self class]];
}

#pragma mark - super
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.pageView.pageViewAppear(self, YJTPageViewAppearWill);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.pageView.pageViewAppear(self, YJTPageViewAppearDid);
}

#pragma mark - 刷新界面
- (void)reloadDataWithPageViewObject:(YJTPageViewObject *)pageViewObject pageView:(YJTPageView *)pageView {
    [self reloadDataSyncWithPageViewObject:pageViewObject pageView:pageView];
    __weak YJTPageViewController *weakSelf = self;
    dispatch_async_main(^{
        [weakSelf reloadDataAsyncWithPageViewObject:weakSelf.pageViewObject pageView:weakSelf.pageView];
    });
}

- (void)reloadDataSyncWithPageViewObject:(YJTPageViewObject *)pageViewObject pageView:(YJTPageView *)pageView {
    _pageViewObject = pageViewObject;
    _pageView = pageView;
}

- (void)reloadDataAsyncWithPageViewObject:(YJTPageViewObject *)pageViewObject pageView:(YJTPageView *)pageView {
   
}

@end
