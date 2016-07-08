//
//  YJCollectionReusableView.m
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJCollectionReusableView.h"

#pragma mark - UICollectionReusableView (YJCollectionView)
@implementation UICollectionReusableView (YJCollectionView)

#pragma mark (+)
+ (id)cellObject {
    return [[YJCollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
}

+ (id)cellObjectWithCellModel:(id<YJCollectionCellModel>)cellModel {
    YJCollectionCellObject *cellObject = [[YJCollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
    cellObject.cellModel = cellModel;
    return cellObject;
}


#pragma mark (-)
- (void)reloadDataWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate {
    [self reloadDataSyncWithCellObject:cellObject delegate:delegate];
    __weak UICollectionReusableView *weakSelf = self;
    dispatch_async_main(^{// UI加速
        [weakSelf reloadDataAsyncWithCellObject:cellObject delegate:delegate];
    });
}

- (void)reloadDataSyncWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate {
    
}

- (void)reloadDataAsyncWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate {
    
}

@end

#pragma mark YJCollectionViewCell
@implementation YJCollectionReusableView

- (void)reloadDataSyncWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate {
    _cellObject = cellObject;
    _delegate = delegate;
}

@end
