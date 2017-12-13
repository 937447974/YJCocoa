//
//  YJNSKeyValueObserver.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/12/13.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** KVO 回调*/
typedef void (^ YJNSKVOBlock)(id oldValue, id newValue);

/** KVO 观察者*/
@interface YJNSKeyValueObserver : NSObject

@property (nonatomic) BOOL removed ; ///< 是否已被移除

@property (nonatomic, weak, readonly) NSObject *observer;    ///< 观察者对象
@property (nonatomic, copy, readonly) NSString *keyPath;     ///< 参数路径
@property (nonatomic, copy, readonly) YJNSKVOBlock kvoBlock; ///< block回调

/**
 *  @abstract 初始化
 *
 *  @param observer 观察者对象
 *  @param keyPath  参数路径
 *  @param kvoBlock kvo回调
 *
 *  @return instancetype
 */
- (instancetype)initWithObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath kvoBlock:(YJNSKVOBlock)kvoBlock;

@end

NS_ASSUME_NONNULL_END

