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

@class YJUITableViewManager;

@protocol YJUITableViewCellProtocol <NSObject>

@optional

/**
 *  用户点击Cell中的某个控件，如按钮
 *
 *  @param tableViewCell 用户操作的cell
 *  @param cellObject    cell携带的数据源
 *
 *  @return void
 */
- (void)tableViewCell:(UITableViewCell *)cell sendWithCellObject:(YJUITableCellObject *)cellObject;

@end

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
+ (CGFloat)tableViewManager:(YJUITableViewManager *)tableViewManager heightForCellObject:(YJUITableCellObject *)cellObject;

/**
 *  刷新UITableViewCell（同步&异步，子类请勿重写）
 *
 *  @param cellObject        YJUITableCellObject
 *  @param tableViewDelegate YJUITableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager;

/**
 *  刷新UITableViewCell（同步）
 *
 *  @param cellObject        YJUITableCellObject
 *  @param tableViewDelegate YJUITableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataSyncWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager;

/**
 *  刷新UITableViewCell（异步）
 *
 *  @param cellObject        YJUITableCellObject
 *  @param tableViewDelegate YJUITableViewDelegate
 *
 *  @return void
 */
- (void)reloadDataAsyncWithCellObject:(YJUITableCellObject *)cellObject tableViewManager:(YJUITableViewManager *)tableViewManager;

@end


/** UITableViewCell基类（*/
@interface YJUITableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) YJUITableCellObject *cellObject;        ///< YJUITableCellObject
@property (nonatomic, weak, readonly) YJUITableViewManager *tableViewManager; ///< YJUITableViewManager

@end

NS_ASSUME_NONNULL_END
