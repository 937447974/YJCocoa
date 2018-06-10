//
//  YJUICollectionView.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/6/9.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//


#import "YJUICollectionView.h"

@implementation YJUICollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _manager = [[YJUICollectionViewManager alloc] initWithCollectionView:self];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _manager = [[YJUICollectionViewManager alloc] initWithCollectionView:self];
}

#pragma mark - getter
- (NSMutableArray<YJUICollectionCellObject *> *)dataSourcePlain {
    return self.manager.dataSourcePlain;
}

- (void)setDataSourcePlain:(NSMutableArray<YJUICollectionCellObject *> *)dataSourcePlain {
    self.manager.dataSourcePlain = dataSourcePlain;
}

- (NSMutableArray<NSMutableArray<YJUICollectionCellObject *> *> *)dataSourceGrouped {
    return self.manager.dataSourceGrouped;
}

- (NSMutableArray<YJUICollectionCellObject *> *)dataSourceHeader {
    return self.manager.dataSourceManager.dataSourceHeader;
}

- (NSMutableArray<YJUICollectionCellObject *> *)dataSourceFooter {
    return self.manager.dataSourceManager.dataSourceFooter;
}

@end
