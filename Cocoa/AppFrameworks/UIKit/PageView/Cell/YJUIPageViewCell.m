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

- (instancetype)initPageView {
    return [self init];
}

#pragma mark - 刷新界面
- (void)reloadDataWithPageViewCellObject:(YJUIPageViewCellObject *)cellObject pageView:(YJUIPageView *)pageView {
    _cellObject = cellObject;
    _pageView = pageView;
}

@end
