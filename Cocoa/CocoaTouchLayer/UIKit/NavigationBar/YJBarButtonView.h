//
//  YJBarButtonView.h
//  YJNavigationBar
//
//  Created by admin on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 按钮View*/
@interface YJBarButtonView : UIView

@property (nonatomic, strong) UIColor *titleColor; ///< 字体颜色，默认黑色
@property (nonatomic, strong) UIFont *titleFont;   ///< 字体大小，默认14
@property (nonatomic) CGFloat highlightedAlpha;    ///< 点击高亮时的透明度，默认0.5
@property (nonatomic) CGFloat spacing;             ///< 按钮之间的间隔,默认5

@property (nonatomic, copy) void(^ reloadData)(BOOL animation); ///< UI刷新的回调，框架使用

/**
 * To customize the appearance of all instances of a class, send the relevant appearance modification messages to the appearance proxy for the class.
 *
 *  @return instancetype
 */
+ (instancetype)appearance;

@end
 
NS_ASSUME_NONNULL_END
