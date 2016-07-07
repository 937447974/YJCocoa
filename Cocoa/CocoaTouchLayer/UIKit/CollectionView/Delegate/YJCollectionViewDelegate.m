//
//  YJCollectionViewDelegate.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJCollectionViewDelegate.h"
#import "YJCollectionViewDataSource.h"
#import "YJFoundationOther.h"

@interface YJCollectionViewDelegate () {
    CGFloat _contentOffsetY; ///< scrollView.contentOffset.y
    UICollectionViewFlowLayout *_flowLayout;
    NSMutableDictionary<NSString *, NSString*> *_cacheSizeDict; ///< 缓存Size
}

@property (nonatomic) YJCollectionViewScroll scroll; ///< 滚动

@end

@implementation YJCollectionViewDelegate

#pragma mark - init
- (instancetype)initWithDataSource:(YJCollectionViewDataSource *)dataSource {
    self = [super init];
    if (self) {
        _dataSource = dataSource;
        _cacheSizeDict = [[NSMutableDictionary alloc] init];
        _isCacheSize = YES;
        if ([dataSource.collectionView.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
            _flowLayout = (UICollectionViewFlowLayout *)dataSource.collectionView.collectionViewLayout;
        }
    }
    return self;
}

#pragma mark - getter and setter
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [self.dataSource.collectionView setCollectionViewLayout:_flowLayout animated:YES];// 动态替换
    }
    return _flowLayout;
}

- (void)setScroll:(YJCollectionViewScroll)scroll {
    if (scroll != _scroll && [self.cellDelegate respondsToSelector:@selector(collectionView:scroll:)]) {
        _scroll = scroll;
        [self.cellDelegate collectionView:self.dataSource.collectionView scroll:scroll];
    }
}

#pragma mark - UICollectionViewCell向VC发送数据
- (void)sendVCWithCellObject:(YJCollectionCellObject *)cellObject collectionViewCell:(UICollectionViewCell *)cell {
    if (self.cellBlock) { // block回调
        self.cellBlock(cellObject, cell);
    } else if ([self.cellDelegate respondsToSelector:@selector(collectionViewDidSelectCellWithCellObject:collectionViewCell:)]){
        [self.cellDelegate collectionViewDidSelectCellWithCellObject:cellObject collectionViewCell:cell];
    }
}

#pragma mark 清除所有缓存Size
- (void)clearAllCacheSize {
    [_cacheSizeDict removeAllObjects];
}

#pragma mark 获取cellObject对应的缓存key
- (NSString *)getKeyFromCellObject:(YJCollectionCellObject *)cellObject {
    switch (self.cacheSizeStrategy) {
        case YJCollectionViewCacheSizeDefault: // 根据相同的UITableViewCell类缓存高度
            return cellObject.cellName;
        case YJCollectionViewCacheSizeIndexPath: // 根据NSIndexPath对应的位置缓存高度
            return [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.item];
        case YJCollectionViewCacheSizeClassAndIndexPath: // 根据类名和NSIndexPath双重绑定缓存高度
            return [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.item];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _contentOffsetY = scrollView.contentOffset.y;
    self.scroll = YJCollectionViewScrollNone;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.cellDelegate respondsToSelector:@selector(collectionView:scroll:)]) {
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        CGFloat spacing = contentOffsetY - _contentOffsetY;
        if (contentOffsetY <= 0) {
            self.scroll = YJCollectionViewScrollEndTop;
        } else if (spacing >= 10 ) {
            self.scroll = YJCollectionViewScrollDidTop;
        } else if (spacing >= 5 && self.scroll != YJCollectionViewScrollDidTop) {
            self.scroll = YJCollectionViewScrollWillTop;
        } else if (spacing <= -10 ) {
            self.scroll = YJCollectionViewScrollDidBottom;
        } else if (spacing <= -5 && self.scroll != YJCollectionViewScrollDidBottom) {
            self.scroll = YJCollectionViewScrollWillBottom;
        }
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *lastIndexPath = self.dataSource.dataSourceGrouped.lastObject.lastObject.indexPath;
    if (indexPath && indexPath.section == lastIndexPath.section && indexPath.item == lastIndexPath.item  && [self.cellDelegate respondsToSelector:@selector(collectionViewLoadingPageData:willDisplayCell:)]) { // 加载数据
        YJCollectionCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.item];
        [self.cellDelegate collectionViewLoadingPageData:cellObject willDisplayCell:cell];
    }    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YJCollectionCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.item];
    [self sendVCWithCellObject:cellObject collectionViewCell:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获取YJTableCellObject
    YJCollectionCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.item];
    cellObject.indexPath = indexPath;
    // 存放缓存高的key
    NSString *key = [self getKeyFromCellObject:cellObject];
    CGSize size = self.flowLayout.itemSize;
    NSString *string;
    if (self.isCacheSize) {
        string = [_cacheSizeDict objectForKey:key];
    }
    if (!string) { //无缓存
        // 获取Size
        if ([cellObject.cellClass respondsToSelector:@selector(collectionViewDelegate:sizeForCellObject:)]) {
            size = [cellObject.cellClass collectionViewDelegate:self sizeForCellObject:cellObject];
        }
    } else {
        size = CGSizeFromString(string);
    }
    if (self.lineItems) {
        CGFloat itemW = (collectionView.frame.size.width - self.flowLayout.sectionInset.left - self.flowLayout.sectionInset.right - self.flowLayout.minimumInteritemSpacing * (self.lineItems - 1))/self.lineItems;
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

@end
