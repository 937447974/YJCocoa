//
//  NSObject+YJLeaks.h
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/13.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 内存泄漏捕获基类*/
@interface NSObject (YJLeaks)

/**
 *  @abstract 开始内存泄漏分析
 */
+ (void)start;

/**
 *  @abstract 执行泄漏捕获
 *  @discusstion 释放对象前调用
 */
- (void)leaksCapture;

@end

NS_ASSUME_NONNULL_END
