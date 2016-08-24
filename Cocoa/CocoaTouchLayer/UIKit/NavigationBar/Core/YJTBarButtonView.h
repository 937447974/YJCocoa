//
//  YJTBarButtonView.h
//  YJNavigationBar
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTBarButtonItem.h"

NS_ASSUME_NONNULL_BEGIN

/** 按钮View*/
@interface YJTBarButtonView : UIView

@property (nullable, nonatomic, strong) YJTBarButtonItem *barButtonItem; ///< 按钮
@property (nullable, nonatomic, strong) NSArray<YJTBarButtonItem *> *barButtonItems; ///< 按钮集合

@property (nonatomic, strong) UIColor *titleColor; ///< 字体颜色，默认黑色
@property (nonatomic, strong) UIFont *titleFont;   ///< 字体大小，默认14
@property (nonatomic) CGFloat highlightedAlpha;    ///< 点击按钮高亮时的透明度，默认0.5
@property (nonatomic) CGFloat spacing;             ///< 按钮之间的间隔,默认5

@property (nonatomic, copy) void(^ reloadDataBlock)(BOOL animation); ///< UI刷新的回调，框架使用

@end
 
NS_ASSUME_NONNULL_END
