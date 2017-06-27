//
//  NSObject+YJNSPerformSelector.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** performSelector方法扩展*/
@interface NSObject (YJNSPerformSelector)

/**
 *  @abstract 线程安全执行Selector
 *
 *  @param aSelector 方法体
 *  @param objects   携带的参数
 *
 *  @return id
 */
- (id)performSelector:(SEL)aSelector withObjects:(nullable NSArray<id> *)objects;

@end

NS_ASSUME_NONNULL_END
