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

@interface YJUITableViewDelegateManager ()

@property (nonatomic, weak, readwrite) YJUITableViewManager *manager;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *cacheHeightDict;

@end

@implementation YJUITableViewDelegateManager


#pragma mark - init
- (instancetype)initWithManager:(YJUITableViewManager *)manager {
    self = [super init];
    if (self) {
        self.cacheHeightDict = [[NSMutableDictionary alloc] init];
        self.isCacheHeight = YES;
        self.manager = manager;
    }
    return self;
}

#pragma mark - 清除缓存
- (void)clearAllCacheHeight {
    [self.cacheHeightDict removeAllObjects];
}

- (void)clearCacheHeightWithCellObject:(YJUITableCellObject *)cellObject {
    if (!cellObject.indexPath) {
        return;
    }
    [self.cacheHeightDict removeObjectForKey:[self getKeyFromCellObject:cellObject]];
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

- (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJUITableCellObject *)cellObject {
    // 存放缓存高的key
    NSString *key = [self getKeyFromCellObject:cellObject];
    CGFloat rowHeight = 0;
    if (self.isCacheHeight) {
        rowHeight = [self.cacheHeightDict objectForKey:key].floatValue;
        if (rowHeight) return rowHeight;
    }
    rowHeight = [cellObject.cellClass tableViewManager:self.manager heightForCellObject:cellObject];
    // 添加缓存
    if (self.isCacheHeight) {
        [self.cacheHeightDict setObject:[NSNumber numberWithFloat:rowHeight] forKey:key];
    }
    return rowHeight;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_manager.dataSourceGrouped.count <= indexPath.section || _manager.dataSourceGrouped[indexPath.section].count <= indexPath.row) {
        NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
        return self.manager.tableView.rowHeight;
    }
    YJUITableCellObject *cellObject = self.manager.dataSourceGrouped[indexPath.section][indexPath.row];
    cellObject.indexPath = indexPath;
    return [self tableView:tableView heightForCellObject:cellObject];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.manager.dataSourceHeader.count <= section) {
        return 0;
    }
    YJUITableCellObject *cellObject = self.manager.dataSourceHeader[section];
    cellObject.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    return [self tableView:tableView heightForCellObject:cellObject];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.manager.dataSourceHeader.count <= section) {
        return nil;
    }
    YJUITableCellObject *cellObject = self.manager.dataSourceHeader[section];
    cellObject.indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    return [self.manager.dataSourceManager dequeueReusableHeaderFooterViewWithCellObject:cellObject];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.manager.delegate respondsToSelector:@selector(tableViewManager:didSelectCellWithCellObject:)]) {
        if (_manager.dataSourceGrouped.count <= indexPath.section || _manager.dataSourceGrouped[indexPath.section].count <= indexPath.row) {
            NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
            return;
        }
        YJUITableCellObject *co = self.manager.dataSourceGrouped[indexPath.section][indexPath.row];
        !co.didSelectRowBlock?:co.didSelectRowBlock();
        [self.manager.delegate tableViewManager:self.manager didSelectCellWithCellObject:co];
    }
}

@end
