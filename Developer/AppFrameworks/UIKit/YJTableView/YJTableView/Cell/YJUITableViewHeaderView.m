//
//  YJUITableViewHeaderView.m
//  YJTableView
//
//  Created by CISDI on 2018/7/18.
//  Copyright © 2018年 YJ. All rights reserved.
//

#import "YJUITableViewHeaderView.h"

@implementation YJUITableViewHeaderView

- (void)reloadDataWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager {
    [super reloadDataWithCellObject:cellObject tableViewManager:tableViewManager];
    self.textLabel.text = [NSString stringWithFormat:@"%@", cellObject.indexPath];
}

@end
