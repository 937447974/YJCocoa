//
//  YJUITableViewDataSourceManager.h
//  YJTableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/17.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUITableViewManager;

/** UITableViewDataSource管理器*/
@interface YJUITableViewDataSourceManager : NSObject <UITableViewDataSource>

@property (nonatomic, weak, readonly) YJUITableViewManager *manager; ///< YJUITableViewManager

/**
 *  初始化
 *
 *  @param manager YJUITableViewManager
 *
 *  @return YJUITableViewDataSourceManager
 */
- (instancetype)initWithManager:(YJUITableViewManager *)manager;

/**
 *  根据cellObject创建UITableViewCell
 *
 *  @param cellObject YJUITableCellObject
 *
 *  @return UITableViewCell
 */
- (__kindof UITableViewCell *)dequeueReusableCellWithCellObject:(YJUITableCellObject *)cellObject;

/**
 *  快速刷新已加载cell
 *
 *  @param cellObjects NSArray<YJUITableCellObject *>
 *
 *  @return void
 */
- (void)reloadRowsAtIndexPaths:(NSArray<YJUITableCellObject *> *)cellObjects;

@end

NS_ASSUME_NONNULL_END
