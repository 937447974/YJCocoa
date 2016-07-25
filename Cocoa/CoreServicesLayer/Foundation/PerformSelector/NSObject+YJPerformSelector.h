//
//  NSObject+YJPerformSelector.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/25.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJPerformSelector.h"

NS_ASSUME_NONNULL_BEGIN

/** performSelector方法扩展*/
@interface NSObject (YJPerformSelector)

/**
 *  线程安全执行Selector
 *
 *  @param aSelector 方法体
 *  @param objects   携带的参数
 *
 *  @return void
 */
- (YJPerformSelector *)performSelector:(SEL)aSelector withObjects:(nullable NSArray<id> *)objects;

@end

NS_ASSUME_NONNULL_END
