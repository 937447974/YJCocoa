//
//  YJUITableViewHeaderFooterView.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/7/18.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class YJUITableViewManager;

/** UITableViewCell扩展*/
@interface UITableViewHeaderFooterView (YJUITableView) <YJUITableViewCellProtocol>
@end


/** UITableViewHeaderFooterView 基类*/
@interface YJUITableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak, readonly) YJUITableCellObject *cellObject;        ///< YJUITableCellObject
@property (nonatomic, weak, readonly) YJUITableViewManager *tableViewManager; ///< YJUITableViewManager

@end

NS_ASSUME_NONNULL_END

