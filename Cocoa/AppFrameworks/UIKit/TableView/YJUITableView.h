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

#import <UIKit/UIKit.h>
#import "YJUITableViewManager.h"

@interface YJUITableView : UITableView

@property (nonatomic, strong, readonly) YJUITableViewManager *manager; ///< 管理器
@property (nonatomic, strong, readonly) NSMutableArray<YJUITableCellObject *> *dataSourcePlain; ///< 数据源UITableViewStylePlain
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray<YJUITableCellObject *> *> *dataSourceGrouped; ///< 数据源UITableViewStyleGrouped

@end

