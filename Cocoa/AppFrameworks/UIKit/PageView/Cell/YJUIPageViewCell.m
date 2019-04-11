//
//  YJUIPageViewCell.m
//  PageViewManager
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/2/9.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJUIPageViewCell.h"

@interface YJUIPageViewCell ()

@property (nonatomic, copy) YJUIPageViewCellDidAppear cellDidAppear;

@end

@implementation YJUIPageViewCell

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    !self.cellDidAppear?:self.cellDidAppear(self.cellObject.pageIndex);
}

#pragma mark - YJUIPageViewCellProtocol
+ (YJUIPageViewCellObject *)cellObjectWithCellModel:(id)cellModel {
    YJUIPageViewCellObject *co = [[YJUIPageViewCellObject alloc] initWithPageClass:[self class]];
    co.cellModel = cellModel;
    return co;
}

- (void)reloadDataWithPageViewCellObject:(YJUIPageViewCellObject *)cellObject pageViewManager:(YJUIPageViewManager *)pageViewManager {
    self.cellObject = cellObject;
    self.pageViewManager = pageViewManager;
}

@end
