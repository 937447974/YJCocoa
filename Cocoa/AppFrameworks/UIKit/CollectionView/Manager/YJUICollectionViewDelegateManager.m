//
//  YJUICollectionViewDelegateManager.m
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionViewDelegateManager.h"
#import "YJUICollectionViewManager.h"

@implementation YJUICollectionViewDelegateManager

- (instancetype)initWithManager:(YJUICollectionViewManager *)manager {
    self = [self init];
    if (self) {
        _manager = manager;
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.manager.delegate respondsToSelector:@selector(collectionViewManager:didSelectCellWithCellObject:)]) {
        if (_manager.dataSourceGrouped.count <= indexPath.section || _manager.dataSourceGrouped[indexPath.section].count <= indexPath.item) {
            NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
            return;
        }
        YJUICollectionCellObject *cellObject = self.manager.dataSourceGrouped[indexPath.section][indexPath.item];
        [self.manager.delegate collectionViewManager:self.manager didSelectCellWithCellObject:cellObject];
    }
}

@end
