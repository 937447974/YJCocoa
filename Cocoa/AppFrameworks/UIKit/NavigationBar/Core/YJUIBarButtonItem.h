//
//  YJUIBarButtonItem.h
//  YJNavigationBar
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 按钮大小高度为30，宽度自适应最小30
// 标题图片可同时使用

/** 模仿UIBarButtonItem*/
@interface YJUIBarButtonItem : NSObject

@property (nonatomic) CGFloat tag; ///< 标记

@property (nullable, nonatomic, copy)   NSString *title; ///< 使用标题
@property (nullable, nonatomic, strong) UIImage *image;  ///< 使用图片

@property (nullable, nonatomic, weak) id target;  ///< 回调目标
@property (nullable, nonatomic)       SEL action; ///< 回调方法

/**
 *  通过文字初始化
 *
 *  @param title 标题
 *  @param target 回调目标
 *  @param action 回调方法
 *
 *  @return YJBarButtonItem
 */
- (instancetype)initWithTitle:(nullable NSString *)title target:(nullable id)target action:(nullable SEL)action;

/**
 *  通过图片初始化
 *
 *  @param image 图片
 *  @param target 回调目标
 *  @param action 回调方法
 *
 *  @return YJBarButtonItem
 */
- (instancetype)initWithImage:(nullable UIImage *)image target:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
