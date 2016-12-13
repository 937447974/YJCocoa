//
//  YJTestCollectionViewCell.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTestCollectionViewCell.h"

@implementation YJTestCollectionViewCell

+ (YJUICollectionCellCreate)cellCreate {
    return YJUICollectionCellCreateXib;
}

- (void)reloadDataSyncWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager {
    [super reloadDataSyncWithCellObject:cellObject collectionViewManager:collectionViewManager];
    YJTestCollectionCellModel *cellModel = cellObject.cellModel;
    self.label.text = cellModel.index;
}

@end
