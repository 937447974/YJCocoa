//
//  YJScheduler.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/12/29.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJSchedulerHeader.h"
#import "YJNSSingleton.h"

NS_ASSUME_NONNULL_BEGIN

#define YJSchedulerS YJNSSingletonS(YJScheduler, nil)

/** 调度中心*/
@interface YJScheduler : NSObject

#pragma mark subscribe
/**
 *  @abstract 订阅
 *
 *  @param topic      主题
 *  @param subscriber 订阅者，自动释放（传入nil代表永不释放）
 *  @param queue      回调执行的队列
 *  @param handler    接受发布方传输的数据
 */
- (void)subscribeTopic:(NSString *)topic subscriber:(nullable id)subscriber onQueue:(YJSchedulerQueue)queue completionHandler:(YJSSubscribeHandler)handler;

/**
 *  @abstract 取消订阅
 *
 *  @param topic 主题
 *  @param subscriber 订阅者
 */
- (void)removeSubscribeTopic:(nullable NSString *)topic subscriber:(id)subscriber;

#pragma mark intercept
/**
 *  @abstract 拦截发布信息
 *
 *  @param interceptor 拦截者
 *  @param canHandler  能否拦截
 *  @param handler     拦截后执行的操作
 */
- (void)interceptWithInterceptor:(nullable id)interceptor canHandler:(YJSInterceptCanHandler)canHandler completionHandler:(YJSInterceptHandler)handler;

#pragma mark publish
/**
 *  @abstract 能否发布
 *
 *  @param topic 主题
 *
 *  @return BOOL
 */
- (BOOL)canPublishTopic:(NSString *)topic;

/**
 *  @abstract 发布信息
 *
 *  @param topic   主题
 *  @param data    携带的数据
 *  @param serial  yes串行发布no并行发布
 *  @param handler 接受方处理数据后的回调
 */
- (void)publishTopic:(NSString *)topic data:(nullable id)data serial:(BOOL)serial completionHandler:(nullable YJSPublishHandler)handler;

@end

NS_ASSUME_NONNULL_END


