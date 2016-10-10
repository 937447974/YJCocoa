//
//  YJTTableViewCell.h
//  YJTTableViewFactory
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/21.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTTableCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTTableViewDelegate;

/** UITableViewCell扩展*/
@interface UITableViewCell (YJTTableView)

/**
 *  获取初始化cell的方式
 *
 *  @return YJTTableViewCellCreate
 */
+ (YJTTableViewCellCreate)cellCreate;

/**
 *  获取YJTTableCellObject,子类重写可获取YJTTableCellObject子类。
 *
 *  @return YJTTableCellObject
 */
+ (id)cellObject;

/**
 *  获取YJTTableCellObject并自动填充模型。
 *
 *  @param cellModel 对应的Cell模型
 *
 *  @return YJTTableCellObject
 */
+ (id)cellObjectWithCellModel:(id<YJTTableCellModelProtocol>)cellModel;

/**
 *  获取cell的显示高。子类不实行时，会根据xib设置的高度自动计算高
 *
 *  @param cellObject cell封装的对象
 *
 *  @return CGFloat
 */
+ (CGFloat)tableView:(UITableView *)tableView heightForCellObject:(YJTTableCellObject *)cellObject;

/**
 *  刷新UITableViewCell（同步&异步，子类请勿重写）
 *
 *  @param cellObject        YJTTableCellObject
 *  @param tableViewDelegate YJTTableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataWithCellObject:(YJTTableCellObject *)cellObject tableViewDelegate:(YJTTableViewDelegate *)tableViewDelegate;

/**
 *  刷新UITableViewCell（同步）
 *
 *  @param cellObject        YJTTableCellObject
 *  @param tableViewDelegate YJTTableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataSyncWithCellObject:(YJTTableCellObject *)cellObject tableViewDelegate:(YJTTableViewDelegate *)tableViewDelegate;

/**
 *  刷新UITableViewCell（异步）
 *
 *  @param cellObject        YJTTableCellObject
 *  @param tableViewDelegate YJTTableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataAsyncWithCellObject:(YJTTableCellObject *)cellObject tableViewDelegate:(YJTTableViewDelegate *)tableViewDelegate;

@end


/** UITableViewCell基类（*/
@interface YJTTableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) YJTTableCellObject *cellObject;          ///< YJTTableCellObject
@property (nonatomic, weak, readonly) YJTTableViewDelegate *tableViewDelegate; ///< YJTTableViewDelegate

@end

NS_ASSUME_NONNULL_END