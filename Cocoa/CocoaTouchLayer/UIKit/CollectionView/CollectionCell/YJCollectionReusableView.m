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
+ (YJCollectionCellCreate)cellCreate {
    return YJCollectionCellCreateDefault;
}

+ (id)cellObject {
    YJCollectionCellObject *cellObject = [[YJCollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
    cellObject.createCell = [self cellCreate];
    return [[YJCollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
}

+ (id)cellObjectWithCellModel:(id<YJCollectionCellModel>)cellModel {
    YJCollectionCellObject *cellObject = [self cellObject];
    cellObject.cellModel = cellModel;
    return cellObject;
}

+ (CGSize)collectionViewDelegate:(YJCollectionViewDelegate *)delegate viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJCollectionCellObject *)cellObject {
    if (cellObject.createCell == YJCollectionCellCreateDefault) { // 默认使用xib创建cell
        NSArray<UIView *> *array = [[NSBundle mainBundle] loadNibNamed:YJStringFromClass(self.class) owner:nil options:nil];
        return array.firstObject.frame.size;
    }
    // 默认设置
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        return delegate.flowLayout.headerReferenceSize;
    }
    return delegate.flowLayout.footerReferenceSize;
}

#pragma mark (-)
- (void)reloadDataWithCellObject:(YJCollectionCellObject *)cellObject delegate:(YJCollectionViewDelegate *)delegate {
    [self reloadDataSyncWithCellObject:cellObject delegate:delegate];
    __weakSelf
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
