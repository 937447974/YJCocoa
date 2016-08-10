//
//  YJTableViewDelegate.m
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTableViewDelegate.h"
#import "YJTableViewDataSource.h"
#import "YJTableCellObject.h"
#import "YJTableViewCell.h"
#import "YJFoundationOther.h"
#import "UIView+YJViewGeometry.h"

@interface YJTableViewDelegate () {
    CGFloat _contentOffsetY; ///< scrollView.contentOffset.y
    CGFloat _contentOffsetYBegin; ///< 开始的点
    NSMutableDictionary<NSString *, NSNumber *> *_cacheHeightDict; ///< 缓存高
    YJSuspensionCellView *_suspensionCellView;
}

@property (nonatomic) YJTableViewScroll scroll; ///< 滚动

@end

@implementation YJTableViewDelegate

#pragma mark - init
- (instancetype)initWithDataSource:(YJTableViewDataSource *)dataSource {
    self = [super init];
    if (self) {
        _cacheHeightDict = [[NSMutableDictionary alloc] init];
        _isCacheHeight = YES;
        _dataSource = dataSource;
        _contentOffsetYBegin = CGFLOAT_MAX;
        self.scrollSpacingWill = 15;
        self.scrollSpacingDid = 30;
    }
    return self;
}

#pragma mark - getter and setter
- (YJSuspensionCellView *)suspensionCellView {
    if (!_suspensionCellView) {
        self.suspensionCellView = [[YJSuspensionCellView alloc] initWithFrame:CGRectMake(0, 0, self.dataSource.tableView.frame.size.width, 0)];
        [self.dataSource.tableView.superview addSubview:_suspensionCellView];
    }
    return _suspensionCellView;
}

- (void)setSuspensionCellView:(YJSuspensionCellView *)suspensionCellView {
    _suspensionCellView = suspensionCellView;
    _suspensionCellView.tableViewDelegate = self;
}

- (void)setScroll:(YJTableViewScroll)scroll {
    if (scroll != _scroll && [self.cellDelegate respondsToSelector:@selector(tableView:scroll:)]) {
        _scroll = scroll;
        [self.cellDelegate tableView:self.dataSource.tableView scroll:scroll];
    }
}

#pragma mark - UITableViewCell向VC发送数据
- (void)sendVCWithCellObject:(YJTableCellObject *)cellObject tableViewCell:(UITableViewCell *)cell {
    if (self.cellBlock) { // block回调
        self.cellBlock(cellObject, cell);
    } else if ([self.cellDelegate respondsToSelector:@selector(tableViewDidSelectCellWithCellObject:tableViewCell:)]) { // 协议回调
        [self.cellDelegate tableViewDidSelectCellWithCellObject:cellObject tableViewCell:cell];
    }
}

#pragma mark - 清除缓存
- (void)clearAllCacheHeight {
    [_cacheHeightDict removeAllObjects];
}

- (void)clearCacheHeightWithCellObject:(YJTableCellObject *)cellObject {
    if (!cellObject.indexPath) {
        return;
    }
    [_cacheHeightDict removeObjectForKey:[self getKeyFromCellObject:cellObject]];    
}

- (void)clearCacheHeightWithCellObjects:(NSArray<YJTableCellObject *> *)cellObjects {
    for (YJTableCellObject *cellObject in cellObjects) {
        [self clearCacheHeightWithCellObject:cellObject];
    }
}

#pragma mark 获取cellObject对应的缓存key
- (NSString *)getKeyFromCellObject:(YJTableCellObject *)cellObject {
    switch (self.cacheHeightStrategy) {
        case YJTableViewCacheHeightDefault: // 根据相同的UITableViewCell类缓存高度
            return cellObject.cellName;
        case YJTableViewCacheHeightIndexPath: // 根据NSIndexPath对应的位置缓存高度
            return [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.row];
        case YJTableViewCacheHeightClassAndIndexPath: // 根据类名和NSIndexPath双重绑定缓存高度
            return [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.row];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _contentOffsetY = scrollView.contentOffset.y;
    if (_contentOffsetYBegin == CGFLOAT_MAX) {
        _contentOffsetYBegin = _contentOffsetY;
    }
    self.scroll = YJTableViewScrollNone;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat spacing = contentOffsetY - _contentOffsetY;
    if (contentOffsetY <= _contentOffsetYBegin) {
        self.scroll = YJTableViewScrollEndTop;
    } else if (contentOffsetY + scrollView.heightFrame >= scrollView.contentSize.height) {
        self.scroll = YJTableViewScrollEndBottom;
    } else if (spacing >= self.scrollSpacingDid) {
        self.scroll = YJTableViewScrollDidTop;
        _contentOffsetY = contentOffsetY;
    } else if (spacing >= self.scrollSpacingWill && self.scroll != YJTableViewScrollDidTop) {
        self.scroll = YJTableViewScrollWillTop;
    } else if (spacing <= -self.scrollSpacingDid) {
        self.scroll = YJTableViewScrollDidBottom;
        _contentOffsetY = contentOffsetY;
    } else if (spacing <= -self.scrollSpacingWill && self.scroll != YJTableViewScrollDidBottom) {
        self.scroll = YJTableViewScrollWillBottom;        
    }
    // 悬浮cel
    self.suspensionCellView.contentOffsetY = self.dataSource.tableView.contentOffset.y;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.dataSourceGrouped.count == 0) {
        return;
    }
    NSInteger section = self.dataSource.dataSourceGrouped.count - 1;
    NSInteger row = self.dataSource.dataSourceGrouped[section].count - 1;    
    if (indexPath.section == section && indexPath.row == row && [self.cellDelegate respondsToSelector:@selector(tableViewLoadingPageData:willDisplayCell:)]) { // 加载数据
        YJTableCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.row];
        [self.cellDelegate tableViewLoadingPageData:cellObject willDisplayCell:cell];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取YJTableCellObject
    YJTableCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.row];
    cellObject.indexPath = indexPath;
    // 存放缓存高的key
    NSString *key = [self getKeyFromCellObject:cellObject];
    CGFloat rowHeight = 0;
    if (self.isCacheHeight) {
        rowHeight = [_cacheHeightDict objectForKey:key].floatValue;
    }
    if (rowHeight == 0) { //无缓存
        // 获取高
        if (cellObject && [cellObject.cellClass respondsToSelector:@selector(tableView:heightForCellObject:)] ) {
            rowHeight = [cellObject.cellClass tableView:tableView heightForCellObject:cellObject];
        }
    }
    // 获取失败时，使用默认高
    rowHeight = rowHeight ? rowHeight : tableView.rowHeight;
    // 添加缓存
    if (self.isCacheHeight) {
        [_cacheHeightDict setObject:[NSNumber numberWithFloat:rowHeight] forKey:key];
    }
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTableCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.row];
    [self sendVCWithCellObject:cellObject tableViewCell:nil];
}

@end
