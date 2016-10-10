//
//  YJTCollectionReusableView.m
//  YJTCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJTCollectionReusableView.h"

#pragma mark - UICollectionReusableView (YJTCollectionView)
@implementation UICollectionReusableView (YJTCollectionView)

#pragma mark (+)
+ (YJTCollectionCellCreate)cellCreate {
    return YJTCollectionCellCreateDefault;
}

+ (id)cellObject {
    YJTCollectionCellObject *cellObject = [[YJTCollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
    cellObject.createCell = [self cellCreate];
    return [[YJTCollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
}

+ (id)cellObjectWithCellModel:(id<YJTCollectionCellModel>)cellModel {
    YJTCollectionCellObject *cellObject = [self cellObject];
    cellObject.cellModel = cellModel;
    return cellObject;
}

+ (CGSize)collectionViewDelegate:(YJTCollectionViewDelegate *)delegate viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJTCollectionCellObject *)cellObject {
    if (cellObject.createCell == YJTCollectionCellCreateDefault) { // 默认使用xib创建cell
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
- (void)reloadDataWithCellObject:(YJTCollectionCellObject *)cellObject delegate:(YJTCollectionViewDelegate *)delegate {
    [self reloadDataSyncWithCellObject:cellObject delegate:delegate];
    __weakSelf
    dispatch_async_main(^{// UI加速
        [weakSelf reloadDataAsyncWithCellObject:cellObject delegate:delegate];
    });
}

- (void)reloadDataSyncWithCellObject:(YJTCollectionCellObject *)cellObject delegate:(YJTCollectionViewDelegate *)delegate {
    
}

- (void)reloadDataAsyncWithCellObject:(YJTCollectionCellObject *)cellObject delegate:(YJTCollectionViewDelegate *)delegate {
    
}

@end

#pragma mark YJTCollectionViewCell
@implementation YJTCollectionReusableView

- (void)reloadDataSyncWithCellObject:(YJTCollectionCellObject *)cellObject delegate:(YJTCollectionViewDelegate *)delegate {
    _cellObject = cellObject;
    _delegate = delegate;
}

@end
