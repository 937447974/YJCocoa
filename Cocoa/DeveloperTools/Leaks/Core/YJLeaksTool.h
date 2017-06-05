//
//  YJLeaksTool.h
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/6/5.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJNSSingleton.h"

#if DEBUG

// 单例
#define YJLeaksToolS [YJLeaksTool strongSingleton:nil]

/** 工具包*/
@interface YJLeaksTool : NSObject

@property (nonatomic, strong, readonly) NSMutableSet<Class> *ignoredClasses; ///< 忽略的对象集合（白名单）

/**
 *  @abstract 执行捕获目标内存泄漏
 *  @discusstion 释放对象前调用
 */
- (void)captureTargetMemoryLeaks:(NSObject *)target;

@end

#endif

