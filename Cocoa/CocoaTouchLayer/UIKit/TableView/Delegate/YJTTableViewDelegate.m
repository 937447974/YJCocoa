//
//  YJTTableViewDelegate.m
//  YJTTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTTableViewDelegate.h"
#import "YJTTableViewDataSource.h"
#import "YJTTableCellObject.h"
#import "YJTTableViewCell.h"
#import "YJSFoundationOther.h"
#import "UIView+YJTViewGeometry.h"
#import "YJTAutoLayout.h"

@interface YJTTableViewDelegate () {
    CGFloat _contentOffsetY; ///< scrollView.contentOffset.y
    CGFloat _contentOffsetYBegin; ///< 开始的点
    NSMutableDictionary<NSString *, NSNumber *> *_cacheHeightDict; ///< 缓存高
    YJTSuspensionCellView *_suspensionCellView;
}

@property (nonatomic) YJTTableViewScroll scroll; ///< 滚动

@end

@implementation YJTTableViewDelegate

#pragma mark - init
- (instancetype)initWithDataSource:(YJTTableViewDataSource *)dataSource {
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
- (YJTSuspensionCellView *)suspensionCellView {
    if (!_suspensionCellView) {
        self.suspensionCellView = [[YJTSuspensionCellView alloc] initWithFrame:self.dataSource.tableView.frame];
        self.suspensionCellView.heightFrame = 0;
        _suspensionCellView.clipsToBounds = YES;
        [self.dataSource.tableView.superview addSubview:_suspensionCellView];
        if (!self.dataSource.tableView.translatesAutoresizingMaskIntoConstraints) { // 约束
            _suspensionCellView.topLayout.equalTo(self.dataSource.tableView.topLayout);
            _suspensionCellView.leadingLayout.equalTo(self.dataSource.tableView.leadingLayout);
            _suspensionCellView.trailingLayout.equalTo(self.dataSource.tableView.trailingLayout);
            _suspensionCellView.heightLayout.equalToConstant(0);
        }
    }
    return _suspensionCellView;
}

- (void)setSuspensionCellView:(YJTSuspensionCellView *)suspensionCellView {
    _suspensionCellView = suspensionCellView;
    _suspensionCellView.tableViewDelegate = self;
}

- (void)setScroll:(YJTTableViewScroll)scroll {
    if (scroll != _scroll && [self.cellDelegate respondsToSelector:@selector(tableView:scroll:)]) {
        _scroll = scroll;
        [self.cellDelegate tableView:self.dataSource.tableView scroll:scroll];
    }
}

#pragma mark - UITableViewCell向VC发送数据
- (void)sendVCWithCellObject:(YJTTableCellObject *)cellObject tableViewCell:(UITableViewCell *)cell {
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

- (void)clearCacheHeightWithCellObject:(YJTTableCellObject *)cellObject {
    if (!cellObject.indexPath) {
        return;
    }
    [_cacheHeightDict removeObjectForKey:[self getKeyFromCellObject:cellObject]];    
}

- (void)clearCacheHeightWithCellObjects:(NSArray<YJTTableCellObject *> *)cellObjects {
    for (YJTTableCellObject *cellObject in cellObjects) {
        [self clearCacheHeightWithCellObject:cellObject];
    }
}

#pragma mark 获取cellObject对应的缓存key
- (NSString *)getKeyFromCellObject:(YJTTableCellObject *)cellObject {
    switch (self.cacheHeightStrategy) {
        case YJTTableViewCacheHeightDefault: // 根据相同的UITableViewCell类缓存高度
            return cellObject.cellName;
        case YJTTableViewCacheHeightIndexPath: // 根据NSIndexPath对应的位置缓存高度
            return [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.row];
        case YJTTableViewCacheHeightClassAndIndexPath: // 根据类名和NSIndexPath双重绑定缓存高度
            return [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.row];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _contentOffsetY = scrollView.contentOffset.y;
    if (_contentOffsetYBegin == CGFLOAT_MAX) {
        _contentOffsetYBegin = _contentOffsetY;
    }
    self.scroll = YJTTableViewScrollNone;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat spacing = contentOffsetY - _contentOffsetY;
    if (contentOffsetY <= _contentOffsetYBegin) {
        self.scroll = YJTTableViewScrollEndTop;
    } else if (contentOffsetY + scrollView.heightFrame >= scrollView.contentSize.height) {
        self.scroll = YJTTableViewScrollEndBottom;
    } else if (spacing >= self.scrollSpacingDid) {
        self.scroll = YJTTableViewScrollDidTop;
        _contentOffsetY = contentOffsetY;
    } else if (spacing >= self.scrollSpacingWill && self.scroll != YJTTableViewScrollDidTop) {
        self.scroll = YJTTableViewScrollWillTop;
    } else if (spacing <= -self.scrollSpacingDid) {
        self.scroll = YJTTableViewScrollDidBottom;
        _contentOffsetY = contentOffsetY;
    } else if (spacing <= -self.scrollSpacingWill && self.scroll != YJTTableViewScrollDidBottom) {
        self.scroll = YJTTableViewScrollWillBottom;        
    }
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
        YJTTableCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.row];
        [self.cellDelegate tableViewLoadingPageData:cellObject willDisplayCell:cell];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取YJTTableCellObject
    YJTTableCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.row];
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
    YJTTableCellObject *cellObject = self.dataSource.dataSourceGrouped[indexPath.section][indexPath.row];
    [self sendVCWithCellObject:cellObject tableViewCell:nil];
}

@end
