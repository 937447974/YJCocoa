//
//  YJUISuspensionCellView.h
//  YJUITableView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/23.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YJUITableViewManager;

/** 悬浮的cell层*/
@interface YJUISuspensionCellView : UIView

@property (nonatomic, weak) YJUITableViewManager *manager; ///< YJUITableViewManager

@property (nonatomic) CGFloat contentOffsetY; ///< 偏移Y

/**
 *  刷新数据
 *
 *  @return void
 */
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
