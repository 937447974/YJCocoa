//
//  YJNSSingleton.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/3/14.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YJNSSingletonMCenter.h"

NS_ASSUME_NONNULL_BEGIN

/** strong单例宏*/
#define YJNSSingletonS(Class, identifier) [Class strongSingleton:identifier]

/** weak单例宏*/
#define YJNSSingletonW(Class, identifier) [Class weakSingleton:identifier]

/** 类单例扩展*/
@interface NSObject (YJNSSingleton)

/**
 *  strong单例（随应用一直存在）
 *
 *  @param identifier 自定义标签（nil时使用类名做标签）
 *
 *  @return instancetype
 */
+ (instancetype)strongSingleton:(nullable NSString *)identifier;

/**
 *  weak单例（内存警告时回收）
 *
 *  @param identifier 自定义标签（nil时使用类名做标签）
 *
 *  @return instancetype
 */
+ (instancetype)weakSingleton:(nullable NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
