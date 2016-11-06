//
//  YJUICollectionViewDelegateManager.m
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionViewDelegateManager.h"
#import "YJUICollectionViewManager.h"
#import "UIView+YJUIViewGeometry.h"

@interface YJUICollectionViewDelegateManager () {
    CGFloat _contentOffsetY;      ///< scrollView.contentOffset.y
    CGFloat _contentOffsetYBegin; ///< 开始的点
}

@property (nonatomic) YJUICollectionViewScroll scroll; ///< 滚动

@end

@implementation YJUICollectionViewDelegateManager

- (instancetype)initWithManager:(YJUICollectionViewManager *)manager {
    self = [super init];
    if (self) {
        _manager = manager;
        _contentOffsetYBegin = CGFLOAT_MAX;
        self.scrollSpacingWill = 15;
        self.scrollSpacingDid = 30;
    }
    return self;
}

#pragma mark - getter and setter
- (void)setScroll:(YJUICollectionViewScroll)scroll {
    if (scroll != _scroll && [self.manager.delegate respondsToSelector:@selector(collectionViewManager:scroll:)]) {
        _scroll = scroll;
        [self.manager.delegate collectionViewManager:self.manager scroll:scroll];
        if (scroll == YJUICollectionViewScrollEndBottom && [self.manager.delegate respondsToSelector:@selector(collectionViewManagerloadingPageData:)]) {
            [self.manager.delegate collectionViewManagerloadingPageData:self.manager];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _contentOffsetY = scrollView.contentOffset.y;
    if (_contentOffsetYBegin == CGFLOAT_MAX) {
        _contentOffsetYBegin = _contentOffsetY;
    }
    self.scroll = YJUICollectionViewScrollNone;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat spacing = contentOffsetY - _contentOffsetY;
    if (contentOffsetY <= _contentOffsetYBegin) {
        self.scroll = YJUICollectionViewScrollEndTop;
    } else if (contentOffsetY + scrollView.heightFrame >= scrollView.contentSize.height) {
        self.scroll = YJUICollectionViewScrollEndBottom;
    } else if (spacing >= self.scrollSpacingDid ) {
        self.scroll = YJUICollectionViewScrollDidBottom;
        _contentOffsetY = contentOffsetY;
    } else if (spacing >= self.scrollSpacingWill && self.scroll != YJUICollectionViewScrollDidBottom) {
        self.scroll = YJUICollectionViewScrollWillBottom;
    } else if (spacing <= -self.scrollSpacingDid ) {
        self.scroll = YJUICollectionViewScrollDidTop;
        _contentOffsetY = contentOffsetY;
    } else if (spacing <= -self.scrollSpacingWill && self.scroll != YJUICollectionViewScrollDidTop) {
        self.scroll = YJUICollectionViewScrollWillTop;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.manager.delegate respondsToSelector:@selector(collectionViewManager:didSelectCellWithCellObject:)]) {
        YJUICollectionCellObject *cellObject = self.manager.dataSourceGrouped[indexPath.section][indexPath.item];
        [self.manager.delegate collectionViewManager:self.manager didSelectCellWithCellObject:cellObject];
    }
}

@end
