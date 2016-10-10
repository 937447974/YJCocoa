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

+ (CGSize)collectionViewDelegate:(YJUICollectionViewDelegate *)delegate viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJUICollectionCellObject *)cellObject {
    if (cellObject.createCell == YJUICollectionCellCreateClass) {
        return CGSizeMake(10, 100);
    }
    return [super collectionViewDelegate:delegate viewForSupplementaryElementOfKind:kind referenceSizeForCellObject:cellObject];
}

- (void)reloadDataAsyncWithCellObject:(YJUICollectionCellObject *)cellObject delegate:(YJUICollectionViewDelegate *)delegate {
    YJTestCollectionReusableViewModel *cm = cellObject.cellModel;
    self.backgroundColor = cm.backgroundColor;
}

@end
