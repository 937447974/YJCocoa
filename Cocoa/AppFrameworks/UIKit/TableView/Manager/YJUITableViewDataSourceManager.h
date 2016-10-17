//
//  YJUITableViewDataSourceManager.h
//  YJTableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/17.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUITableCellObject.h"
#import "YJUITableViewCell.h"
#import "YJNSAspectOrientProgramming.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUITableViewManager;

/** 缓存Cell的策略*/
typedef NS_ENUM(NSInteger, YJUITableViewCacheCell) {
    YJUITableViewCacheCellDefault,          ///< 根据相同的UITableViewCell类名缓存Cell
    YJUITableViewCacheCellIndexPath,        ///< 根据NSIndexPath对应的位置缓存Cell
    YJUITableViewCacheCellClassAndIndexPath ///< 根据类名和NSIndexPath双重绑定缓存Cell
};

/** UITableViewDataSource管理器*/
@interface YJUITableViewDataSourceManager : NSObject <UITableViewDataSource>

@property (nonatomic) YJUITableViewCacheCell cacheCellStrategy; ///< 缓存Cell的策略

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
