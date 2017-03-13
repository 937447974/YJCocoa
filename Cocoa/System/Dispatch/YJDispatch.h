//
//  YJDispatch.h
//  YJDispatch
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <pthread.h>

NS_ASSUME_NONNULL_BEGIN

/** 弱引用*/
#define __weakSelf   __weak __typeof__(self) weakSelf = self;
/** 强引用*/
#define __strongSelf __strong __typeof(weakSelf) strongSelf = weakSelf;

/** 主线程运行,同步执行*/
FOUNDATION_EXPORT void dispatch_sync_main(dispatch_block_t block);
/** 主线程运行,异步UI执行*/
FOUNDATION_EXPORT void dispatch_async_main(dispatch_block_t block);

/** 后台运行*/
FOUNDATION_EXPORT void dispatch_async_background(dispatch_block_t block);

/** 主线程延时执行*/
FOUNDATION_EXPORT void dispatch_after_main(NSTimeInterval delayInSeconds, dispatch_block_t block);

/** 串行队列执行(同步)*/
// void dispatch_sync_serial(const char *label, dispatch_block_t block);

/** 并发队列执行*/
FOUNDATION_EXPORT void dispatch_async_concurrent(dispatch_block_t block);


#pragma mark - timer

/**
 *  @abstract 创建GCD计时器
 *
 *  @param queue    队列
 *  @param interval 间隔
 *  @param handler  回调
 *
 *  @return void
 */
FOUNDATION_EXPORT dispatch_source_t dispatch_timer(dispatch_queue_t _Nullable queue, NSTimeInterval interval, dispatch_block_t handler);
/** 主队列GCD计时器*/
FOUNDATION_EXPORT dispatch_source_t dispatch_timer_main(NSTimeInterval interval, dispatch_block_t handler);
/** DISPATCH_QUEUE_PRIORITY_DEFAULT队列GCD计时器*/
FOUNDATION_EXPORT dispatch_source_t dispatch_timer_default(NSTimeInterval interval, dispatch_block_t handler);


#pragma mark - @符号

#define symbol_at try {} @catch (...) {}


#pragma mark - @finally_execute{}

#define cleanup_block void (^ cleanup_block_t)(void)
typedef cleanup_block;
static inline void executeCleanupBlock (__strong cleanup_block_t _Nonnull * _Nonnull block) {
    (*block)();
}

/**
 {
     @finally_execute {
        NSLog(@"finally_execute{}");
     };
     NSLog(@"finally_execute");
 }
 print "finally_execute \n finally_execute{}"
 */
#define finally_execute symbol_at __strong cleanup_block __attribute__((cleanup(executeCleanupBlock), unused)) = ^


#pragma mark - pthread

/**
 pthread_mutex_t _lock;            //1. @interface内属性
 pthread_mutex_init(&_lock, NULL); //2. init
 {                                 //3. {}内加锁
    @synchronized_pthread (_lock)
 }
 pthread_mutex_destroy(&_lock);    //4. dealloc
 */
#define synchronized_pthread(lock) \
            symbol_at \
            pthread_mutex_lock(&lock); @finally_execute { pthread_mutex_unlock(&lock); };


NS_ASSUME_NONNULL_END
