//
//  YJTSuspensionCellView.h
//  YJTableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/23.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTableCellObject.h"

NS_ASSUME_NONNULL_BEGIN

@class YJTableViewDelegate;

/** 悬浮的cell层*/
@interface YJTSuspensionCellView : UIView

@property (nonatomic, weak) YJTableViewDelegate *tableViewDelegate; ///< YJTableViewDelegate
@property (nonatomic) CGFloat contentOffsetY;                       ///< 偏移Y

/**
 *  刷新数据
 *
 *  @return void
 */
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
