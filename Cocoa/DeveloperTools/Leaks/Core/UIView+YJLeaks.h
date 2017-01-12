//
//  UIView+YJLeaks.h
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YJLeaks)

/**
 *  @abstract 开始内存泄漏分析
 */
+ (void)start;

/**
 *  @abstract 将所有非系统子View加载到内存监听数组中
 */
- (void)allSubview:(UIView *)view toLeaks:(NSPointerArray *)subviews;

@end
