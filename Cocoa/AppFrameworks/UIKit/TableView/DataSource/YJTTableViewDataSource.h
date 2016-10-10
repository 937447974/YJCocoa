//
//  YJTTableViewDataSource.h
//  YJTTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTTableCellObject.h"
#import "YJTTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTTableViewDelegate;

/** 缓存Cell的策略*/
typedef NS_ENUM(NSInteger, YJTTableViewCacheCell) {
    YJTTableViewCacheCellDefault,          ///< 根据相同的UITableViewCell类名缓存Cell
    YJTTableViewCacheCellIndexPath,        ///< 根据NSIndexPath对应的位置缓存Cell
    YJTTableViewCacheCellClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存Cell
};


/** UITableViewDataSource抽象接口*/
@interface YJTTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic) YJTTableViewCacheCell cacheCellStrategy; ///< 缓存Cell的策略

@property (nonatomic, strong) NSMutableArray<YJTTableCellObject *> *dataSource; ///< 数据源UITableViewStylePlain
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray<YJTTableCellObject *> *> *dataSourceGrouped; ///< 数据源UITableViewStyleGrouped

@property (nonatomic, weak) UITableView *tableView;                              ///< tableView
@property (nonatomic, strong, readonly) YJTTableViewDelegate *tableViewDelegate; ///< YJTTableViewDelegate,无须赋值，自动化创建

/**
 *  抽象的初始化接口,会自动填充设置tableView.dataSource = self;tableView.delegate = self.tableViewDelegate;
 *
 *  @param tableView UITableView
 *
 *  @return YJTTableViewDataSourceGrouped 或 YJTTableViewDataSourcePlain
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 *  根据cellObject创建UITableViewCell
 *
 *  @param cellObject YJTTableCellObject
 *
 *  @return UITableViewCell
 */
- (__kindof UITableViewCell *)dequeueReusableCellWithCellObject:(YJTTableCellObject *)cellObject;

/**
 *  快速刷新已加载cell
 *
 *  @param cellObjects NSArray<YJTTableCellObject *>
 *
 *  @return void
 */
- (void)reloadRowsAtIndexPaths:(NSArray<YJTTableCellObject *> *)cellObjects;

@end

NS_ASSUME_NONNULL_END
