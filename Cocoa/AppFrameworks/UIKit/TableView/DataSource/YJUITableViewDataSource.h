//
//  YJUITableViewDataSource.h
//  YJUITableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUITableCellObject.h"
#import "YJUITableViewCell.h"
#import "YJNSAspectOrientProgramming.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUITableViewDelegate;

/** 缓存Cell的策略*/
typedef NS_ENUM(NSInteger, YJUITableViewCacheCell) {
    YJUITableViewCacheCellDefault,          ///< 根据相同的UITableViewCell类名缓存Cell
    YJUITableViewCacheCellIndexPath,        ///< 根据NSIndexPath对应的位置缓存Cell
    YJUITableViewCacheCellClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存Cell
};


/** UITableViewDataSource抽象接口*/
@interface YJUITableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic) YJUITableViewCacheCell cacheCellStrategy; ///< 缓存Cell的策略

@property (nonatomic, strong) NSMutableArray<YJUITableCellObject *> *dataSource; ///< 数据源UITableViewStylePlain
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray<YJUITableCellObject *> *> *dataSourceGrouped; ///< 数据源UITableViewStyleGrouped

@property (nonatomic, weak) UITableView *tableView;                              ///< tableView
@property (nonatomic, strong, readonly) YJUITableViewDelegate *tableViewDelegate; ///< YJUITableViewDelegate,无须赋值，自动化创建

/**
 *  抽象的初始化接口,会自动填充设置tableView.dataSource = self;tableView.delegate = self.tableViewDelegate;
 *
 *  @param tableView UITableView
 *
 *  @return YJUITableViewDataSourceGrouped 或 YJUITableViewDataSourcePlain
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 *  @abstract UITableView的AOP代理
 *  @discusstion VC想实现UITableViewDataSource和UITableViewDelegate时，又不想替换框架中的方法，可通过此属性的addTarget:添加
 *
 *  @param delegate id<UITableViewDataSource, UITableViewDelegate>
 *
 *  @return void
 */
- (void)addTableViewAOPDelegate:(id)delegate;

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
