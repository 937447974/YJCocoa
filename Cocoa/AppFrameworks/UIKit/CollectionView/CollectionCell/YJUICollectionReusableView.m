//
//  YJUICollectionReusableView.m
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJUICollectionReusableView.h"

#pragma mark - UICollectionReusableView (YJUICollectionView)
@implementation UICollectionReusableView (YJUICollectionView)

#pragma mark (+)
+ (YJUICollectionCellCreate)cellCreate {
    return YJUICollectionCellCreateDefault;
}

+ (id)cellObject {
    YJUICollectionCellObject *cellObject = [[YJUICollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
    cellObject.createCell = [self cellCreate];
    return [[YJUICollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
}

+ (id)cellObjectWithCellModel:(id<YJUICollectionCellModel>)cellModel {
    YJUICollectionCellObject *cellObject = [self cellObject];
    cellObject.cellModel = cellModel;
    return cellObject;
}

+ (CGSize)collectionViewDelegate:(YJUICollectionViewDelegate *)delegate viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJUICollectionCellObject *)cellObject {
    if (cellObject.createCell == YJUICollectionCellCreateDefault) { // 默认使用xib创建cell
        NSArray<UIView *> *array = [[NSBundle mainBundle] loadNibNamed:YJNSStringFromClass(self.class) owner:nil options:nil];
        return array.firstObject.frame.size;
    }
    // 默认设置
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        return delegate.flowLayout.headerReferenceSize;
    }
    return delegate.flowLayout.footerReferenceSize;
}

#pragma mark (-)
- (void)reloadDataWithCellObject:(YJUICollectionCellObject *)cellObject delegate:(YJUICollectionViewDelegate *)delegate {
    [self reloadDataSyncWithCellObject:cellObject delegate:delegate];
    __weakSelf
    dispatch_async_main(^{// UI加速
        [weakSelf reloadDataAsyncWithCellObject:cellObject delegate:delegate];
    });
}

- (void)reloadDataSyncWithCellObject:(YJUICollectionCellObject *)cellObject delegate:(YJUICollectionViewDelegate *)delegate {
    
}

- (void)reloadDataAsyncWithCellObject:(YJUICollectionCellObject *)cellObject delegate:(YJUICollectionViewDelegate *)delegate {
    
}

@end

#pragma mark YJUICollectionViewCell
@implementation YJUICollectionReusableView

- (void)reloadDataSyncWithCellObject:(YJUICollectionCellObject *)cellObject delegate:(YJUICollectionViewDelegate *)delegate {
    _cellObject = cellObject;
    _delegate = delegate;
}

@end
