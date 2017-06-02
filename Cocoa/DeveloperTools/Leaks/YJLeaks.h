//
//  YJLeaks.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 内存泄漏分析器*/
@interface YJLeaks : NSObject

@property (class, nonatomic, strong, readonly) NSMutableSet<Class> *ignoredClasses; ///< 忽略的对象集合（白名单）

/**
 *  @abstract 开始内存泄漏分析
 */
+ (void)start;

@end
