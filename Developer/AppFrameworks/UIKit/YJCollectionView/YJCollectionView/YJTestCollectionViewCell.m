//
//  YJTestCollectionViewCell.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTestCollectionViewCell.h"

@implementation YJTestCollectionCellModel

@end


@implementation YJTestCollectionViewCell

- (void)reloadDataAsyncWithCellObject:(YJUICollectionCellObject *)cellObject delegate:(YJUICollectionViewDelegate *)delegate {
    [super reloadDataAsyncWithCellObject:cellObject delegate:delegate];
    YJTestCollectionCellModel *cellModel = cellObject.cellModel;
    self.label.text = cellModel.index;
}

@end
