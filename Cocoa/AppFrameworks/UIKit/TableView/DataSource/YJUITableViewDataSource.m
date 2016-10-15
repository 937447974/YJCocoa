//
//  YJUITableViewDataSource.m
//  YJUITableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUITableViewDataSource.h"
#import "YJUITableViewDelegate.h"

@interface YJUITableViewDataSource () {
    YJNSAspectOrientProgramming *_tableViewAOPDelegate; ///< 切面代理
}

@end

@implementation YJUITableViewDataSource

#pragma mark - main
- (instancetype)initWithTableView:(UITableView *)tableView {    
    self = [super init];
    if (self) {
        _dataSourceGrouped = [NSMutableArray array];
        self.dataSource = [NSMutableArray array];
        self.tableView = tableView;
        _tableViewDelegate = [[YJUITableViewDelegate alloc] initWithDataSource:self];
        // 默认设置代理
        self.tableView.dataSource = self;
        self.tableView.delegate = self.tableViewDelegate;
    }
    return self;
}

#pragma mark 快速刷新已加载cell
- (void)reloadRowsAtIndexPaths:(NSArray<YJUITableCellObject *> *)cellObjects; {
    UITableViewCell *cell;
    for (YJUITableCellObject *cellObject in cellObjects) {
        cell = [self.tableView cellForRowAtIndexPath:cellObject.indexPath];
        [cell reloadDataWithCellObject:cellObject tableViewDelegate:self.tableViewDelegate];
    }
}

#pragma mark - getter and setter
- (void)setDataSource:(NSMutableArray<YJUITableCellObject *> *)dataSource {
    _dataSource = dataSource;
    [self.dataSourceGrouped removeAllObjects];
    [self.dataSourceGrouped addObject:_dataSource];
}

- (void)setCacheCellStrategy:(YJUITableViewCacheCell)cacheCellStrategy {
    _cacheCellStrategy = cacheCellStrategy;
    switch (cacheCellStrategy) {
        case YJUITableViewCacheCellDefault:  ///< 根据相同的UITableViewCell类名缓存Cell
            self.tableViewDelegate.cacheHeightStrategy = YJUITableViewCacheHeightDefault;
            break;
        case YJUITableViewCacheCellIndexPath: ///< 根据NSIndexPath对应的位置缓存Cell
            self.tableViewDelegate.cacheHeightStrategy = YJUITableViewCacheHeightIndexPath;
            break;
        case YJUITableViewCacheCellClassAndIndexPath:
            self.tableViewDelegate.cacheHeightStrategy = YJUITableViewCacheHeightClassAndIndexPath;
            break;
    }
}

- (YJNSAspectOrientProgramming *)tableViewAOPDelegate {
    if (!_tableViewAOPDelegate) {
        _tableViewAOPDelegate = [[YJNSAspectOrientProgramming alloc] init];
        [_tableViewAOPDelegate addTarget:self];
        [_tableViewAOPDelegate addTarget:self.tableViewDelegate];
        // 默认设置代理
        self.tableView.dataSource = (id<UITableViewDataSource>)_tableViewAOPDelegate;
        self.tableView.delegate = (id<UITableViewDelegate>)_tableViewAOPDelegate;
    }
    return _tableViewAOPDelegate;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceGrouped.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSourceGrouped objectAtIndex:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJUITableCellObject *cellObject = self.dataSourceGrouped[indexPath.section][indexPath.row];
    cellObject.indexPath = indexPath;
    return [self dequeueReusableCellWithCellObject:cellObject];
}

#pragma mark 根据YJUITableCellObject生成UITableViewCell
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJUITableCellObject *)cellObject {    
    NSString *identifier = @"identifier";
    switch (self.cacheCellStrategy) {
        case YJUITableViewCacheCellDefault:
            identifier = cellObject.cellName;
            break;
        case YJUITableViewCacheCellIndexPath:
            identifier = [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.row];
            break;
        case YJUITableViewCacheCellClassAndIndexPath:
            identifier = [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.row];
            break;
    }
    // 读取缓存
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    // 未找到时，重新注入，再寻找
    if (cell == nil) {
        switch (cellObject.createCell) {
            case YJUITableViewCellCreateDefault:
                [self.tableView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellReuseIdentifier:identifier];
                cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
                break;
            case YJUITableViewCellCreateSoryboard:
                NSLog(@"Soryboard中请使用%@设置cell的Identifier属性", cellObject.cellName);
                break;
            case YJUITableViewCellCreateClass:
                cell = [[cellObject.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                break;
        }
    }
    // 刷新数据
    [cell reloadDataWithCellObject:cellObject tableViewDelegate:self.tableViewDelegate];
    return cell;
}

@end
