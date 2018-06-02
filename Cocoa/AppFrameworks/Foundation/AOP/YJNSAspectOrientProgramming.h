//
//  YJNSAspectOrientProgramming.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/14.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

// 调用方法未防止崩溃，需先执行respondsToSelector判断

/** 面向切面编程*/
@interface YJNSAspectOrientProgramming : NSObject

/**
 *  @abstract 添加切面的接受者
 *
 *  @param target 接受者
 */
- (void)addTarget:(id)target;

/**
 *  @abstract 移除切面的接受者
 *
 *  @param target 接受者
 */
- (void)removeTarget:(id)target;

@end
