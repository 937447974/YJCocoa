//
//  NSObject+YJNSKVO.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/12/13.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSKeyValueObserver.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YJNSKVO)

/**
 *  @abstract 添加 KVO 监听
 *  @discusstion 无须调用removeKVObserver，observer释放时自动移除KVO监听
 *
 *  @param observer 观察者对象
 *  @param keyPath  参数路径
 *  @param kvoBlock kvo回调
 */
- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath kvoBlock:(YJNSKVOBlock)kvoBlock;

/**
 *  @abstract 移除 KVO 监听
 *
 *  @param observer 观察者对象
 *  @param keyPath  参数路径
 */
- (void)removeKVObserver:(NSObject *)observer forKeyPath:(nullable NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
