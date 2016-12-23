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

@interface YJUITableViewDelegateManager () {
    NSMutableDictionary<NSString *, NSNumber *> *_cacheHeightDict; ///< 缓存高
    YJUISuspensionCellView *_suspensionCellView; ///< 悬浮cell
}

@end

@implementation YJUITableViewDelegateManager


#pragma mark - init
- (instancetype)initWithManager:(YJUITableViewManager *)manager {
    self = [super init];
    if (self) {
        _cacheHeightDict = [[NSMutableDictionary alloc] init];
        _isCacheHeight = YES;
        _manager = manager;
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
    }
    return _suspensionCellView;
}

- (void)setSuspensionCellView:(YJUISuspensionCellView *)suspensionCellView {
    _suspensionCellView = suspensionCellView;
    _suspensionCellView.manager = self.manager;
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
            return [NSString stringWithFormat:@"%ld-%ld", (long)cellObject.indexPath.section, (long)cellObject.indexPath.row];
        case YJUITableViewCacheHeightClassAndIndexPath: // 根据类名和NSIndexPath双重绑定缓存高度
            return [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, (long)cellObject.indexPath.section, (long)cellObject.indexPath.row];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.suspensionCellView.contentOffsetY = scrollView.contentOffset.y;
}

#pragma mark - UITableViewDelegate
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
        if (rowHeight) return rowHeight;
    }
    rowHeight = [cellObject.cellClass tableViewManager:self.manager heightForCellObject:cellObject];
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
