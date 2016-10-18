//
//  YJTestCollectionReusableView.m
//  YJCollectionView
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTestCollectionReusableView.h"

@implementation YJTestCollectionReusableViewModel

@end

@implementation YJTestCollectionReusableView

+ (CGSize)collectionViewManager:(YJUICollectionViewManager *)collectionViewManager viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJUICollectionCellObject *)cellObject {
    if (cellObject.createCell == YJUICollectionCellCreateClass) {
        return CGSizeMake(10, 100);
    }
    return [super collectionViewManager:collectionViewManager viewForSupplementaryElementOfKind:kind referenceSizeForCellObject:cellObject];
}

- (void)reloadDataAsyncWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager {
    [super reloadDataAsyncWithCellObject:cellObject collectionViewManager:collectionViewManager];
    YJTestCollectionReusableViewModel *cm = cellObject.cellModel;
    self.backgroundColor = cm.backgroundColor;
}

@end
