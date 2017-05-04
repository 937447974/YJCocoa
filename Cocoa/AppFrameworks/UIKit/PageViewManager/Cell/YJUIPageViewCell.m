//
//  YJUIPageViewCell.m
//  PageViewManager
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/2/9.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YJUIPageViewCell.h"

@interface YJUIPageViewCell ()

@property (nonatomic, copy) void (^ viewDidAppearBlock)(YJUIPageViewCell *cell); ///< cell显示, 框架使用

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.viewDidAppearBlock(self);
}

#pragma mark - 刷新界面
- (void)reloadDataWithPageViewCellObject:(YJUIPageViewCellObject *)cellObject pageViewManager:(YJUIPageViewManager *)pageViewManager {
    _cellObject = cellObject;
    _pageViewManager = pageViewManager;
}

@end
