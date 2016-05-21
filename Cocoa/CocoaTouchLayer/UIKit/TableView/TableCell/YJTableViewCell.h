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
 *  根据模型刷新Cell
 *
 *  @param cellObject        cell封装的对象
 *  @param tableViewDelegate YJTableViewDelegate
 *
 *  @return void
 */
- (void)reloadCellWithCellObject:(YJTableCellObject *)cellObject tableViewDelegate:(YJTableViewDelegate *)tableViewDelegate;

@end


/** UITableViewCell基类*/
@interface YJTableViewCell : UITableViewCell

@property (nonatomic, weak, readonly) YJTableCellObject *cellObject;          ///< cell对象
@property (nonatomic, weak, readonly) YJTableViewDelegate *tableViewDelegate; ///< UITableViewDelegate抽象接口

@end

NS_ASSUME_NONNULL_END