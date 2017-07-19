//
//  YJDispatch.m
//  YJDispatch
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJDispatch.h"

#pragma mark - gcd

// 主线程运行,同步
void dispatch_sync_main(dispatch_block_t block) {
    NSThread.currentThread.isMainThread ? block() : dispatch_sync(dispatch_get_main_queue(), block);
}

// 主线程运行,异步
void dispatch_async_main(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

// queue default 运行
void dispatch_async_default(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

// 后台运行
void dispatch_async_background(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), block);
}

// 主线程延时执行
void dispatch_after_main(NSTimeInterval delayInSeconds, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

/*
// 串行队列执行
void dispatch_sync_serial(const char *label, dispatch_block_t block) {
    // 串行队列：只有一个线程，加入到队列中的操作按添加顺序依次执行
    dispatch_sync(dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL), block);
}

// 并发队列
void dispatch_async_concurrent(const char *label, dispatch_block_t block) {
    // 并发队列：有多个线程，操作进来之后它会将这些队列安排在可用的处理器上，同时保证先进来的任务优先处理
    // dispatch_queue_create("com.starming.concurrentqueue", DISPATCH_QUEUE_CONCURRENT)
    dispatch_async(dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT), block);
}
*/

#pragma mark - timer
dispatch_source_t dispatch_timer(dispatch_queue_t queue, NSTimeInterval interval, dispatch_block_t handler) {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (timer) {
        interval = interval * NSEC_PER_SEC;
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, interval), interval, interval/1000);
        dispatch_source_set_event_handler(timer, handler);
        dispatch_resume(timer);
    }
    return timer;
}

dispatch_source_t dispatch_timer_main(NSTimeInterval interval, dispatch_block_t handler) {
    return dispatch_timer(dispatch_get_main_queue(), interval, handler);
}

dispatch_source_t dispatch_timer_default(NSTimeInterval interval, dispatch_block_t handler) {
    return dispatch_timer(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), interval, handler);
}



