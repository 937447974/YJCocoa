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

+ (CGSize)collectionViewDelegate:(YJTCollectionViewDelegate *)delegate viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJTCollectionCellObject *)cellObject {
    if (cellObject.createCell == YJTCollectionCellCreateClass) {
        return CGSizeMake(10, 100);
    }
    return [super collectionViewDelegate:delegate viewForSupplementaryElementOfKind:kind referenceSizeForCellObject:cellObject];
}

- (void)reloadDataAsyncWithCellObject:(YJTCollectionCellObject *)cellObject delegate:(YJTCollectionViewDelegate *)delegate {
    YJTestCollectionReusableViewModel *cm = cellObject.cellModel;
    self.backgroundColor = cm.backgroundColor;
}

@end
