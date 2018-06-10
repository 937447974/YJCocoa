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

@interface YJUITableViewDataSourceManager ()

@property (nonatomic, strong) NSMutableSet<NSString *> *identifierSet; ///< 记录缓存过的identifier

@end

@implementation YJUITableViewDataSourceManager

- (instancetype)initWithManager:(YJUITableViewManager *)manager {
    self = [super init];
    if (self) {
        _manager = manager;
        self.identifierSet = [NSMutableSet set];
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

#pragma mark - 生成UITableViewCell
- (UITableViewCell *)dequeueReusableCellWithCellObject:(YJUITableCellObject *)cellObject {
    if (![self.identifierSet containsObject:cellObject.reuseIdentifier]) {
        switch (cellObject.createCell) {
            case YJUITableViewCellCreateClass:
                [self.manager.tableView registerClass:cellObject.cellClass forCellReuseIdentifier:cellObject.reuseIdentifier];
                break;
            case YJUITableViewCellCreateXib:
                [self.manager.tableView registerNib:[UINib nibWithNibName:cellObject.cellName bundle:nil] forCellReuseIdentifier:cellObject.reuseIdentifier];
                break;
            case YJUITableViewCellCreateSoryboard:
                break;
        }
        [self.identifierSet addObject:cellObject.reuseIdentifier];
    }
    UITableViewCell *cell = [_manager.tableView dequeueReusableCellWithIdentifier:cellObject.reuseIdentifier forIndexPath:cellObject.indexPath];
    [cell reloadDataWithCellObject:cellObject tableViewManager:_manager];
    return cell;
}

@end
