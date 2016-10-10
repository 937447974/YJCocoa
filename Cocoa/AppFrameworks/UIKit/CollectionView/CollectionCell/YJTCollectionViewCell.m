//
//  YJTCollectionViewCell.m
//  YJTCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTCollectionViewCell.h"

@implementation UICollectionViewCell (YJTCollectionView)

+ (CGSize)collectionViewDelegate:(YJTCollectionViewDelegate *)delegate sizeForCellObject:(YJTCollectionCellObject *)cellObject {
    if (cellObject.createCell == YJTCollectionCellCreateDefault) { // 默认使用xib创建cell
        NSArray<UIView *> *array = [[NSBundle mainBundle] loadNibNamed:YJStringFromClass(self.class) owner:nil options:nil];
        return array.firstObject.frame.size;
    }
    return delegate.flowLayout.itemSize; // 默认设置
}

@end

@implementation YJTCollectionViewCell

- (void)reloadDataSyncWithCellObject:(YJTCollectionCellObject *)cellObject delegate:(YJTCollectionViewDelegate *)delegate {
    _cellObject = cellObject;
    _delegate = delegate;
}

@end