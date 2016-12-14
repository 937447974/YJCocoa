//
//  YJUITableViewDataSourceManager.m
//  YJTableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/17.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUITableViewDataSourceManager.h"
#import "YJUITableViewManager.h"

@implementation YJUITableViewDataSourceManager

- (instancetype)initWithManager:(YJUITableViewManager *)manager {
    self = [super init];
    if (self) {
        _manager = manager;
    }
    return self;
}

#pragma mark 快速刷新已加载cell
- (void)reloadRowsAtIndexPaths:(NSArray<YJUITableCellObject *> *)cellObjects; {
    UITableViewCell *cell;
    for (YJUITableCellObject *cellObject in cellObjects) {
        cell = [self.manager.tableView cellForRowAtIndexPath:cellObject.indexPath];
        [cell reloadDataWithCellObject:cellObject tableViewManager:_manager];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _manager.dataSourceGrouped.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_manager.dataSourceGrouped.count <= section) {
        NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
        return 0;
    }
    return [_manager.dataSourceGrouped objectAtIndex:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_manager.dataSourceGrouped.count <= indexPath.section || _manager.dataSourceGrouped[indexPath.section].count <= indexPath.row) {
        NSLog(@"error:数组越界; selector:%@", NSStringFromSelector(_cmd));
        return [[YJUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YJUITableViewCell"];
    }
    YJUITableCellObject *cellObject = _manager.dataSourceGrouped[indexPath.section][indexPath.row];
    cellObject.indexPath = indexPath;
    return [self dequeueReusableCellWithCellObject:cellObject];
}

#pragma mark 根据YJUITableCellObject生成UITableViewCell
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJUITableCellObject *)cellObject {
    NSString *identifier = cellObject.cellName;
    // 读取缓存
    UITableViewCell *cell = [_manager.tableView dequeueReusableCellWithIdentifier:identifier];
    // 未找到时，重新注入，再寻找
    if (cell == nil) {
        switch (cellObject.createCell) {
            case YJUITableViewCellCreateDefault:
                [_manager.tableView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellReuseIdentifier:identifier];
                cell = [_manager.tableView dequeueReusableCellWithIdentifier:identifier];
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
    [cell reloadDataWithCellObject:cellObject tableViewManager:_manager];
    return cell;
}

@end
