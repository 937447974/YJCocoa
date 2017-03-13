//
//  NSObject+YJNSSingleton.h
//  YJFoundation
//
//  Created by 阳君 on 2017/3/13.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJNSSingletonMCenter.h"

NS_ASSUME_NONNULL_BEGIN

/** strong单例宏*/
#define YJNSSingletonS(Class) [Class strongSingleton]
/** weak单例宏*/
#define YJNSSingletonW(Class) [Class weakSingleton]

/** 类单例扩展*/
@interface NSObject (YJNSSingleton)

/**
 *  strong单例（随应用一直存在）
 *
 *  @return instancetype
 */
+ (instancetype)strongSingleton;

/**
 *  weak单例（内存警告时回收）
 *
 *  @return instancetype
 */
+ (instancetype)weakSingleton;

@end

NS_ASSUME_NONNULL_END
