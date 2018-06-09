//
//  YJUITableView.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/6/9.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUITableView.h"

@implementation YJUITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        _manager = [[YJUITableViewManager alloc] initWithTableView:self];
    }
    return self;
}

#pragma mark - getter
- (NSMutableArray<YJUITableCellObject *> *)dataSourcePlain {
    return self.manager.dataSource;
}

- (NSMutableArray<NSMutableArray<YJUITableCellObject *> *> *)dataSourceGrouped {
    return self.manager.dataSourceGrouped;
}

@end
