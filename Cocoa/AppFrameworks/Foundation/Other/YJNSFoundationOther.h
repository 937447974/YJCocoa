//
//  YJFoundationOther.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//
//  Created by 阳君 on 16/5/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSWeakObject.h"

NS_ASSUME_NONNULL_BEGIN

/** 获取类名，兼容OC和Swift*/
FOUNDATION_EXPORT NSString *YJNSStringFromClass(Class aClass);

@interface NSObject (YJOther)

/**
 *  @abstract 获取所有响应类方法 aSelector 的类
 *
 *  @param aSelector 响应的方法
 *
 *  @return NSArray<Class> *
 */
+ (NSArray<Class> *)allClassRespondsToSelector:(SEL)aSelector;

@end

NS_ASSUME_NONNULL_END
