//
//  YJCollectionViewCell.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJCollectionViewCell.h"
#import "YJCollectionViewDelegate.h"
#import "YJCollectionViewDataSource.h"
#import "YJFoundationOther.h"
#import "YJSystem.h"

#pragma mark - UICollectionViewCell (YJCollectionView)
@implementation UICollectionViewCell (YJCollectionView)
#pragma mark (+)
+ (id)cellObject {
    return [[YJCollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
}

+ (id)cellObjectWithCellModel:(id<YJCollectionCellModel>)cellModel {
    YJCollectionCellObject *cellObject = [[YJCollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
    cellObject.cellModel = cellModel;
    return cellObject;
}

+ (CGSize)collectionViewDelegate:(YJCollectionViewDelegate *)delegate sizeForCellObject:(YJCollectionCellObject *)cellObject {
    if (cellObject.createCell == YJCollectionCellCreateDefault) { // 默认使用xib创建cell
        NSArray<UIView *> *array = [[NSBundle mainBundle] loadNibNamed:YJStringFromClass(self.class) owner:nil options:nil];
        return array.firstObject.frame.size;
    }
    return delegate.flowLayout.itemSize; // 默认设置
}

#pragma mark (-)
- (void)reloadDataWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate {
    [self reloadDataSyncWithCellObject:cellObject delegate:delegate];
    __weak UICollectionViewCell *weakSelf = self;
    dispatch_async_main(^{// UI加速
        [weakSelf reloadDataAsyncWithCellObject:cellObject delegate:delegate];
    });
}

- (void)reloadDataSyncWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate {
    
}

- (void)reloadDataAsyncWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate {
    
}

@end

#pragma mark - YJCollectionViewCell
@implementation YJCollectionViewCell

- (void)reloadDataSyncWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate {
    _cellObject = cellObject;
    _delegate = delegate;
}

@end
