//
//  YJUITableViewDelegateManager.m
//  YJTableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/17.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUITableViewDelegateManager.h"
#import "YJUITableViewManager.h"
#import "UIView+YJUIViewGeometry.h"
#import "YJAutoLayout.h"

@interface YJUITableViewDelegateManager () {
    CGFloat _contentOffsetY; ///< scrollView.contentOffset.y
    CGFloat _contentOffsetYBegin; ///< 开始的点
    NSMutableDictionary<NSString *, NSNumber *> *_cacheHeightDict; ///< 缓存高
    YJUISuspensionCellView *_suspensionCellView; ///< 悬浮cell
}

@property (nonatomic) YJUITableViewScroll scroll; ///< 滚动

@end

@implementation YJUITableViewDelegateManager


#pragma mark - init
- (instancetype)initWithManager:(YJUITableViewManager *)manager {
    self = [super init];
    if (self) {
        _cacheHeightDict = [[NSMutableDictionary alloc] init];
        _isCacheHeight = YES;
        _manager = manager;
        _contentOffsetYBegin = CGFLOAT_MAX;
        self.scrollSpacingWill = 15;
        self.scrollSpacingDid = 30;
    }
    return self;
}

#pragma mark - getter and setter
- (YJUISuspensionCellView *)suspensionCellView {
    if (!_suspensionCellView) {
        self.suspensionCellView = [[YJUISuspensionCellView alloc] initWithFrame:self.manager.tableView.frame];
        self.suspensionCellView.heightFrame = 0;
        _suspensionCellView.clipsToBounds = YES;
        [self.manager.tableView.superview addSubview:_suspensionCellView];
        if (!self.manager.tableView.translatesAutoresizingMaskIntoConstraints) { // 约束
            _suspensionCellView.topLayout.equalTo(self.manager.tableView.topLayout);
            _suspensionCellView.leadingLayout.equalTo(self.manager.tableView.leadingLayout);
            _suspensionCellView.trailingLayout.equalTo(self.manager.tableView.trailingLayout);
            _suspensionCellView.heightLayout.equalToConstant(0);
        }
    }
    return _suspensionCellView;
}

- (void)setSuspensionCellView:(YJUISuspensionCellView *)suspensionCellView {
    _suspensionCellView = suspensionCellView;
    _suspensionCellView.manager = self.manager;
}

- (void)setScroll:(YJUITableViewScroll)scroll {
    if (scroll != _scroll && [self.manager.delegate respondsToSelector:@selector(tableViewManager:scroll:)]) {
        _scroll = scroll;
        [self.manager.delegate tableViewManager:self.manager scroll:scroll];
    }
}

#pragma mark - 清除缓存
- (void)clearAllCacheHeight {
    [_cacheHeightDict removeAllObjects];
}

- (void)clearCacheHeightWithCellObject:(YJUITableCellObject *)cellObject {
    if (!cellObject.indexPath) {
        return;
    }
    [_cacheHeightDict removeObjectForKey:[self getKeyFromCellObject:cellObject]];
}

- (void)clearCacheHeightWithCellObjects:(NSArray<YJUITableCellObject *> *)cellObjects {
    for (YJUITableCellObject *cellObject in cellObjects) {
        [self clearCacheHeightWithCellObject:cellObject];
    }
}

#pragma mark 获取cellObject对应的缓存key
- (NSString *)getKeyFromCellObject:(YJUITableCellObject *)cellObject {
    switch (self.cacheHeightStrategy) {
        case YJUITableViewCacheHeightDefault: // 根据相同的UITableViewCell类缓存高度
            return cellObject.cellName;
        case YJUITableViewCacheHeightIndexPath: // 根据NSIndexPath对应的位置缓存高度
            return [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.row];
        case YJUITableViewCacheHeightClassAndIndexPath: // 根据类名和NSIndexPath双重绑定缓存高度
            return [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.row];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _contentOffsetY = scrollView.contentOffset.y;
    if (_contentOffsetYBegin == CGFLOAT_MAX) {
        _contentOffsetYBegin = _contentOffsetY;
    }
    self.scroll = YJUITableViewScrollNone;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat spacing = contentOffsetY - _contentOffsetY;
    if (contentOffsetY <= _contentOffsetYBegin) {
        self.scroll = YJUITableViewScrollEndTop;
    } else if (contentOffsetY + scrollView.heightFrame >= scrollView.contentSize.height) {
        self.scroll = YJUITableViewScrollEndBottom;
    } else if (spacing >= self.scrollSpacingDid) {
        self.scroll = YJUITableViewScrollDidBottom;
        _contentOffsetY = contentOffsetY;
    } else if (spacing >= self.scrollSpacingWill && self.scroll != YJUITableViewScrollDidBottom) {
        self.scroll = YJUITableViewScrollWillBottom;
    } else if (spacing <= -self.scrollSpacingDid) {
        self.scroll = YJUITableViewScrollDidTop;
        _contentOffsetY = contentOffsetY;
    } else if (spacing <= -self.scrollSpacingWill && self.scroll != YJUITableViewScrollDidTop) {
        self.scroll = YJUITableViewScrollWillTop;
    }
    self.suspensionCellView.contentOffsetY = contentOffsetY;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_manager.dataSourceGrouped.count <= indexPath.section || _manager.dataSourceGrouped[indexPath.section].count <= indexPath.row) {
        NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
        return;
    }
    NSInteger section = self.manager.dataSourceGrouped.count - 1;
    NSInteger row = self.manager.dataSourceGrouped[section].count - 1;
    if (indexPath.section == section && indexPath.row == row && [self.manager.delegate respondsToSelector:@selector(tableViewManager:loadingPageDataWillDisplayCell:)]) { // 加载数据
        [self.manager.delegate tableViewManager:self.manager loadingPageDataWillDisplayCell:cell];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_manager.dataSourceGrouped.count <= indexPath.section || _manager.dataSourceGrouped[indexPath.section].count <= indexPath.row) {
        NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
        return self.manager.tableView.rowHeight;
    }
    // 获取YJUITableCellObject
    YJUITableCellObject *cellObject = self.manager.dataSourceGrouped[indexPath.section][indexPath.row];
    cellObject.indexPath = indexPath;
    // 存放缓存高的key
    NSString *key = [self getKeyFromCellObject:cellObject];
    CGFloat rowHeight = 0;
    if (self.isCacheHeight) {
        rowHeight = [_cacheHeightDict objectForKey:key].floatValue;
    }
    if (rowHeight == 0) { //无缓存
        rowHeight = [cellObject.cellClass tableViewManager:self.manager heightForCellObject:cellObject];
    }
    // 添加缓存
    if (self.isCacheHeight) {
        [_cacheHeightDict setObject:[NSNumber numberWithFloat:rowHeight] forKey:key];
    }
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.manager.delegate respondsToSelector:@selector(tableViewManager:didSelectCellWithCellObject:)]) {
        if (_manager.dataSourceGrouped.count <= indexPath.section || _manager.dataSourceGrouped[indexPath.section].count <= indexPath.row) {
            NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
            return;
        }
        YJUITableCellObject *cellObject = self.manager.dataSourceGrouped[indexPath.section][indexPath.row];
        [self.manager.delegate tableViewManager:self.manager didSelectCellWithCellObject:cellObject];
    }
}

@end
