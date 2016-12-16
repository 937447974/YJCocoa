//
//  YJUICollectionViewDelegateFlowLayoutManager.m
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionViewDelegateFlowLayoutManager.h"
#import "YJUICollectionViewManager.h"
#import "UIView+YJUIViewGeometry.h"

@interface YJUICollectionViewDelegateFlowLayoutManager () {
    NSMutableDictionary<NSString *, NSString*> *_cacheSizeDict; ///< 缓存Size
}

@end

@implementation YJUICollectionViewDelegateFlowLayoutManager

- (instancetype)initWithManager:(YJUICollectionViewManager *)manager {
    self = [super initWithManager:manager];
    if (self) {
        _cacheSizeDict = [[NSMutableDictionary alloc] init];
        _isCacheSize = YES;
    }
    return self;
}

#pragma mark 清除所有缓存Size
- (void)clearAllCacheSize {
    [_cacheSizeDict removeAllObjects];
}

#pragma mark 获取cellObject对应的缓存key
- (NSString *)getKeyFromCellObject:(YJUICollectionCellObject *)cellObject {
    switch (self.cacheSizeStrategy) {
        case YJUICollectionViewCacheSizeDefault: // 根据相同的UITableViewCell类缓存高度
            return cellObject.cellName;
        case YJUICollectionViewCacheSizeIndexPath: // 根据NSIndexPath对应的位置缓存高度
            return [NSString stringWithFormat:@"%ld-%ld", (long)cellObject.indexPath.section, (long)cellObject.indexPath.item];
        case YJUICollectionViewCacheSizeClassAndIndexPath: // 根据类名和NSIndexPath双重绑定缓存高度
            return [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, (long)cellObject.indexPath.section, (long)cellObject.indexPath.item];
    }
}


#pragma mark - getter and setter
- (UICollectionViewFlowLayout *)flowLayout {
    UICollectionViewLayout *flowLayout = self.manager.collectionView.collectionViewLayout;
    if ([flowLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        return (UICollectionViewFlowLayout *)flowLayout;
    }
    return nil;
}

- (void)setLineItems:(CGFloat)lineItems {
    if (_lineItems) {
        [self clearAllCacheSize];
    }
    _lineItems = lineItems;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.manager.dataSourceGrouped.count <= indexPath.section || self.manager.dataSourceGrouped[indexPath.section].count <= indexPath.item) {
        NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
        return self.flowLayout.itemSize;
    }    
    // 获取YJUIableCellObject
    YJUICollectionCellObject *cellObject = self.manager.dataSourceGrouped[indexPath.section][indexPath.item];
    cellObject.indexPath = indexPath;
    // 存放缓存size的key
    NSString *key = [self getKeyFromCellObject:cellObject];
    CGSize size = CGSizeZero;
    NSString *string;
    if (self.isCacheSize) {
        string = [_cacheSizeDict objectForKey:key];
    }
    if (string) {
        return CGSizeFromString(string);
    } else {
        size = [cellObject.cellClass collectionViewManager:self.manager sizeForCellObject:cellObject];
    }
    if (self.lineItems) {
        CGFloat itemW = (collectionView.widthFrame - self.flowLayout.sectionInset.left - self.flowLayout.sectionInset.right - self.flowLayout.minimumInteritemSpacing * (self.lineItems - 1))/self.lineItems;
        if (self.itemHeightLayout) {
            size.height *= itemW / size.width;
        }
        size.width = itemW;
    }
    // 添加缓存
    if (self.isCacheSize) {
        [_cacheSizeDict setObject:NSStringFromCGSize(size) forKey:key];
    }
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [self collectionView:collectionView viewForSupplementaryElementOfKind:UICollectionElementKindSectionHeader referenceSizeForFooterInSection:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return [self collectionView:collectionView viewForSupplementaryElementOfKind:UICollectionElementKindSectionFooter referenceSizeForFooterInSection:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForFooterInSection:(NSInteger)section {
    YJUICollectionCellObject *cellObject;
    NSMutableArray<YJUICollectionCellObject *> *dataSource;
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        dataSource = self.manager.dataSourceManager.headerDataSource;
    } else {
        dataSource = self.manager.dataSourceManager.footerDataSource;
    }
    CGSize size = CGSizeZero;
    if (dataSource.count <= section) {
        return size;
    }
    cellObject = dataSource[section];
    cellObject.indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    // 存放缓存size的key
    NSString *key = [NSString stringWithFormat:@"%@-%@", kind, [self getKeyFromCellObject:cellObject]];
    NSString *string;
    if (self.isCacheSize) {
        string = [_cacheSizeDict objectForKey:key];
        if (string) return CGSizeFromString(string);
    }
    size = [cellObject.cellClass collectionViewManager:self.manager viewForSupplementaryElementOfKind:kind referenceSizeForCellObject:cellObject];
    // 添加缓存
    if (self.isCacheSize) {
        [_cacheSizeDict setObject:NSStringFromCGSize(size) forKey:key];
    }
    return size;
}

@end
