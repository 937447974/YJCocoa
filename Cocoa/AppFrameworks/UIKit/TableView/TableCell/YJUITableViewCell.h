//
//  YJUITableViewCell.h
//  YJUITableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUITableCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUITableViewDelegate;

/** UITableViewCell扩展*/
@interface UITableViewCell (YJUITableView)

/**
 *  获取初始化cell的方式
 *
 *  @return YJUITableViewCellCreate
 */
+ (YJUITableViewCellCreate)cellCreate;

/**
 *  获取YJUITableCellObject,子类重写可获取YJUITableCellObject子类。
 *
 *  @return YJUITableCellObject
 */
+ (id)cellObject;

/**
 *  获取YJUITableCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJUITableCellObject
 */
+ (id)cellObjectWithCellModel:(id<YJUITableCellModelProtocol>)cellModel;

/**
 *  获取cell的显示高。子类不实行时，会根据xib设置的高度自动计算高
 *
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJUITableCellObject *)cellObject;

/**
 *  刷新UITableViewCell（同步&异步，子类请勿重写）
 *
 *  @param cellObject        YJUITableCellObject
 *  @param tableViewDelegate YJUITableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataWithCellObject:(YJUITableCellObject *)cellObject tableViewDelegate:(YJUITableViewDelegate *)tableViewDelegate;

/**
 *  刷新UITableViewCell（同步）
 *
 *  @param cellObject        YJUITableCellObject
 *  @param tableViewDelegate YJUITableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataSyncWithCellObject:(YJUITableCellObject *)cellObject tableViewDelegate:(YJUITableViewDelegate *)tableViewDelegate;

/**
 *  刷新UITableViewCell（异步）
 *
 *  @param cellObject        YJUITableCellObject
 *  @param tableViewDelegate YJUITableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataAsyncWithCellObject:(YJUITableCellObject *)cellObject tableViewDelegate:(YJUITableViewDelegate *)tableViewDelegate;

@end


/** UITableViewCell基类（*/
@interface YJUITableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) YJUITableCellObject *cellObject;          ///< YJUITableCellObject
@property (nonatomic, weak, readonly) YJUITableViewDelegate *tableViewDelegate; ///< YJUITableViewDelegate

@end

NS_ASSUME_NONNULL_END
