//
//  YJUICollectionReusableView.m
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionReusableView.h"
#import "YJUICollectionViewManager.h"
#import "YJDispatch.h"

#pragma mark - UICollectionReusableView (YJUICollectionView)
@implementation UICollectionReusableView (YJUICollectionView)

#pragma mark (+)
+ (YJUICollectionCellCreate)cellCreate {
    return YJUICollectionCellCreateDefault;
}

+ (id)cellObject {
    YJUICollectionCellObject *cellObject = [[YJUICollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
    cellObject.createCell = [self cellCreate];
    return cellObject;
}

+ (id)cellObjectWithCellModel:(id<YJUICollectionCellModel>)cellModel {
    YJUICollectionCellObject *cellObject = [self cellObject];
    cellObject.cellModel = cellModel;
    return cellObject;
}

+ (CGSize)collectionViewManager:(YJUICollectionViewManager *)collectionViewManager viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJUICollectionCellObject *)cellObject {
    if (cellObject.createCell == YJUICollectionCellCreateDefault) { // 默认使用xib创建cell
        NSArray<UIView *> *array = [[NSBundle mainBundle] loadNibNamed:cellObject.cellName owner:nil options:nil];
        return array.firstObject.frame.size;
    }
    // 默认设置
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        return collectionViewManager.delegateFlowLayoutManager.flowLayout.headerReferenceSize;
    }
    return collectionViewManager.delegateFlowLayoutManager.flowLayout.footerReferenceSize;
}

#pragma mark (-)
- (void)reloadDataWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager {
    [self reloadDataSyncWithCellObject:cellObject collectionViewManager:collectionViewManager];
    __weakSelf
    dispatch_async_main(^{// UI加速
        [weakSelf reloadDataAsyncWithCellObject:cellObject collectionViewManager:collectionViewManager];
    });
}

- (void)reloadDataSyncWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager {
}

- (void)reloadDataAsyncWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager {
}

@end

#pragma mark YJUICollectionViewCell
@implementation YJUICollectionReusableView

- (void)reloadDataSyncWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(nonnull YJUICollectionViewManager *)collectionViewManager {
    _cellObject = cellObject;
    _collectionViewManager = collectionViewManager;
}

@end
