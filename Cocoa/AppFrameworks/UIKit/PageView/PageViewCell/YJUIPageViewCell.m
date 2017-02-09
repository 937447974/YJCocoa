//
//  YJUIPageViewCell.m
//  YJPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/2/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YJUIPageViewCell.h"
#import "YJUIPageView.h"

@interface YJUIPageViewCell ()

@end

@implementation YJUIPageViewCell

#pragma mark - (+)
+ (YJUIPageViewCellObject *)cellObjectWithCellModel:(id<YJUIPageViewCellModelProtocol>)cellModel {
    YJUIPageViewCellObject *co = [[YJUIPageViewCellObject alloc] initWithPageClass:[self class]];
    co.cellModel = cellModel;
    return co;
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
- (void)reloadDataWithPageViewCellObject:(YJUIPageViewCellObject *)cellObject pageView:(YJUIPageView *)pageView {
    _cellObject = cellObject;
    _pageView = pageView;
}

@end
