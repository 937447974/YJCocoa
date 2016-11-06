//
//  YJUITableViewManager.m
//  YJTableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/17.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUITableViewManager.h"
#import "YJNSAspectOrientProgramming.h"

@interface YJUITableViewManager () {
    YJNSAspectOrientProgramming *_tableViewAOPDelegate; ///< 切面代理
}

@end

@implementation YJUITableViewManager

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        _dataSourceGrouped = [NSMutableArray array];
        self.dataSource = [NSMutableArray array];
        _tableView = tableView;
        _dataSourceManager = [[YJUITableViewDataSourceManager alloc] initWithManager:self];
        _delegateManager = [[YJUITableViewDelegateManager alloc] initWithManager:self];
        // 设置默认代理
        self.tableView.dataSource = _dataSourceManager;
        self.tableView.delegate = _delegateManager;
    }
    return self;
}

- (void)addTableViewAOPDelegate:(id)delegate {
    if (!_tableViewAOPDelegate) {
        _tableViewAOPDelegate = [[YJNSAspectOrientProgramming alloc] init];
        [_tableViewAOPDelegate addTarget:_dataSourceManager];
        [_tableViewAOPDelegate addTarget:_delegateManager];
    }
    [_tableViewAOPDelegate addTarget:delegate];
    self.tableView.dataSource = (id<UITableViewDataSource>)_tableViewAOPDelegate;
    self.tableView.delegate = (id<UITableViewDelegate>)_tableViewAOPDelegate;
}

#pragma mark - getter and setter
- (void)setDataSource:(NSMutableArray<YJUITableCellObject *> *)dataSource {
    _dataSource = dataSource;
    [self.dataSourceGrouped removeAllObjects];
    [self.dataSourceGrouped addObject:_dataSource];
}

@end
