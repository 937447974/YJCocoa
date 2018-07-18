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

NS_ASSUME_NONNULL_BEGIN

/** UITableView*/
@interface YJUITableView : UITableView

@property (nonatomic, strong) YJUITableViewManager *manager; ///< 管理器
@property (nonatomic, strong) NSMutableArray<YJUITableCellObject *> *dataSourcePlain; ///< 数据源单组
@property (nonatomic, strong) NSMutableArray<NSMutableArray<YJUITableCellObject *> *> *dataSourceGrouped; ///< 数据源多组

@property (nonatomic, strong) NSMutableArray<YJUITableCellObject *> *dataSourceHeader; ///< 数据源头

@end

NS_ASSUME_NONNULL_END
