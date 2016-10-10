//
//  YJTTableViewDataSource.m
//  YJTTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTTableViewDataSource.h"
#import "YJTTableViewDelegate.h"

@implementation YJTTableViewDataSource

#pragma mark - main
- (instancetype)initWithTableView:(UITableView *)tableView {    
    self = [super init];
    if (self) {
        _dataSourceGrouped = [NSMutableArray array];
        self.dataSource = [NSMutableArray array];
        self.tableView = tableView;
        _tableViewDelegate = [[YJTTableViewDelegate alloc] initWithDataSource:self];
        // 默认设置代理
        self.tableView.dataSource = self;
        self.tableView.delegate = self.tableViewDelegate;
    }
    return self;
}

#pragma mark 快速刷新已加载cell
- (void)reloadRowsAtIndexPaths:(NSArray<YJTTableCellObject *> *)cellObjects; {
    UITableViewCell *cell;
    for (YJTTableCellObject *cellObject in cellObjects) {
        cell = [self.tableView cellForRowAtIndexPath:cellObject.indexPath];
        [cell reloadDataWithCellObject:cellObject tableViewDelegate:self.tableViewDelegate];
    }
}

#pragma mark - getter and setter
- (void)setDataSource:(NSMutableArray<YJTTableCellObject *> *)dataSource {
    _dataSource = dataSource;
    [self.dataSourceGrouped removeAllObjects];
    [self.dataSourceGrouped addObject:_dataSource];
}

- (void)setCacheCellStrategy:(YJTTableViewCacheCell)cacheCellStrategy {
    _cacheCellStrategy = cacheCellStrategy;
    switch (cacheCellStrategy) {
        case YJTTableViewCacheCellDefault:  ///< 根据相同的UITableViewCell类名缓存Cell
            self.tableViewDelegate.cacheHeightStrategy = YJTTableViewCacheHeightDefault;
            break;
        case YJTTableViewCacheCellIndexPath: ///< 根据NSIndexPath对应的位置缓存Cell
            self.tableViewDelegate.cacheHeightStrategy = YJTTableViewCacheHeightIndexPath;
            break;
        case YJTTableViewCacheCellClassAndIndexPath:
            self.tableViewDelegate.cacheHeightStrategy = YJTTableViewCacheHeightClassAndIndexPath;
            break;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceGrouped.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSourceGrouped objectAtIndex:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YJTTableCellObject *cellObject = self.dataSourceGrouped[indexPath.section][indexPath.row];
    cellObject.indexPath = indexPath;
    return [self dequeueReusableCellWithCellObject:cellObject];
}

#pragma mark 根据YJTTableCellObject生成UITableViewCell
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJTTableCellObject *)cellObject {    
    NSString *identifier = @"identifier";
    switch (self.cacheCellStrategy) {
        case YJTTableViewCacheCellDefault:
            identifier = cellObject.cellName;
            break;
        case YJTTableViewCacheCellIndexPath:
            identifier = [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.row];
            break;
        case YJTTableViewCacheCellClassAndIndexPath:
            identifier = [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.row];
            break;
    }
    // 读取缓存
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    // 未找到时，重新注入，再寻找
    if (cell == nil) {
        switch (cellObject.createCell) {
            case YJTTableViewCellCreateDefault:
                [self.tableView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellReuseIdentifier:identifier];
                cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
                break;
            case YJTTableViewCellCreateSoryboard:
                NSLog(@"Soryboard中请使用%@设置cell的Identifier属性", cellObject.cellName);
                break;
            case YJTTableViewCellCreateClass:
                cell = [[cellObject.cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                break;
        }
    }
    // 刷新数据
    [cell reloadDataWithCellObject:cellObject tableViewDelegate:self.tableViewDelegate];
    return cell;
}

@end
