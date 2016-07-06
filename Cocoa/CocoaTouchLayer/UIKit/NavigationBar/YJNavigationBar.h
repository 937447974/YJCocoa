//
//  YJNavigationBar.h
//  YJNavigationBar
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJBarButtonView.h"

NS_ASSUME_NONNULL_BEGIN

/*使用方法
 
 */

/** 替换UINavigationItem.titleView*/
@interface YJNavigationBar : UIView

@property (nonatomic, strong) UIColor *titleColor; ///< 字体颜色,默认黑色
@property (nonatomic, strong) UIFont *titleFont;   ///< 字体大小,默认14
@property (nonatomic) CGFloat spacing;             ///< 按钮和标题的间隔,默认10

@property (nullable, nonatomic, copy)   NSString *title;   ///< 标题
@property (nullable, nonatomic, strong) UIView *titleView; ///< 自定义titleView

@property (nullable, nonatomic, strong) YJBarButtonView *leftBarButtonView;  ///< 左按钮View
@property (nullable, nonatomic, strong) YJBarButtonView *rightBarButtonView; ///< 右按钮View

/**
 * To customize the appearance of all instances of a class, send the relevant appearance modification messages to the appearance proxy for the class.
 *
 *  @return instancetype
 */
+ (instancetype)appearance;

@end

NS_ASSUME_NONNULL_END
