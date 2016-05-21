//
//  YJTableViewCell.h
//  YJTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTableCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTableViewDelegate;

/** UITableViewCell扩展*/
@interface UITableViewCell (YJTableView)

/**
 *  获取YJTableCellObject,子类重写可获取YJTableCellObject子类。
 *
 *  @return YJTableCellObject
 */
+ (id)cellObject;

/**
 *  获取YJTableCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJTableCellObject
 */
+ (id)cellObjectWithCellModel:(id<YJTableCellModelProtocol>)cellModel;

/**
 *  获取cell的显示高。子类不实行时，会根据xib设置的高度自动计算高
 *
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJTableCellObject *)cellObject;

/**
 *  刷新UITableViewCell（同步）
 *
 *  @param cellObject        YJTableCellObject
 *  @param tableViewDelegate YJTableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataSyncWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate;

/**
 *  刷新UITableViewCell（异步）
 *
 *  @param cellObject        YJTableCellObject
 *  @param tableViewDelegate YJTableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataAsyncWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate;


- (void)reloadCellWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate __deprecated_msg("方法废弃，请使用reloadDataAsyncWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate替换") __attribute__((visibility("方法废弃")));

@end


/** UITableViewCell基类*/
@interface YJTableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) YJTableCellObject *cellObject;          ///< YJTableCellObject
@property (nonatomic, weak, readonly) YJTableViewDelegate *tableViewDelegate; ///< YJTableViewDelegate

@end

NS_ASSUME_NONNULL_END