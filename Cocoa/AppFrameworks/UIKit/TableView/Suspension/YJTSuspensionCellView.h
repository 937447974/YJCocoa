//
//  YJTSuspensionCellView.h
//  YJTTableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTTableCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTTableViewDelegate;

/** 悬浮的cell层*/
@interface YJTSuspensionCellView : UIView

@property (nonatomic, weak) YJTTableViewDelegate *tableViewDelegate; ///< YJTTableViewDelegate

@property (nonatomic) CGFloat contentOffsetY; ///< 偏移Y

/**
 *  刷新数据
 *
 *  @return void
 */
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
