//
//  YJUIBarButtonItem.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/18.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** UINavigationItem.*BarButtonItem*/
@interface YJUIBarButtonItem : NSObject

/**
 *  @abstract 初始化
 *
 *  @param block 点击回调
 *
 *  @return instancetype
 */
- (instancetype)initWithTouchUpInsideBlock:(dispatch_block_t)block;

/**
 *  @abstract 设置标题
 *
 *  @param title 标题
 *  @param font  字体大小，默认14
 *  @param color 字体颜色，默认 UINavigationBar.barTintColor 或黑色
 *  @param highlightedColor 点击高亮，默认 color 的 0.5 透明度
 */
- (void)setTitle:(NSString *)title font:(nullable UIFont *)font color:(nullable UIColor *)color highlightedColor:(nullable UIColor *)highlightedColor;

/**
 *  @abstract 设置图片
 *
 *  @param image 图片
 *  @param highlightedImage 高亮图片，默认 image 的 0.5 透明度
 */
- (void)setImage:(UIImage *)image highlightedImage:(nullable UIImage *)highlightedImage;

/**
 *  @abstract 设置标题位置
 *
 *  @param titleEdgeInsets button.titleEdgeInsets
 */
- (void)setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;

/**
 *  @abstract 设置图片位置
 *
 *  @param imageEdgeInsets button.imageEdgeInsets
 */
- (void)setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

/**
 *  @abstract 构建为 UIBarButtonItem
 *
 *  @return UIBarButtonItem
 */
- (UIBarButtonItem *)buildBarButtonItem;

@end

NS_ASSUME_NONNULL_END
