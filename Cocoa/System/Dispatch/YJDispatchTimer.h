//
//  YJDispatchTimer.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/9/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  @abstract 创建GCD计时器
 *
 *  @param queue    队列
 *  @param interval 间隔
 *  @param handler  回调
 */
DISPATCH_EXPORT dispatch_source_t dispatch_timer(dispatch_queue_t _Nullable queue, NSTimeInterval interval, dispatch_block_t handler);
/** 主队列GCD计时器*/
DISPATCH_EXPORT dispatch_source_t dispatch_timer_main(NSTimeInterval interval, dispatch_block_t handler);
/** DISPATCH_QUEUE_PRIORITY_DEFAULT队列GCD计时器*/
DISPATCH_EXPORT dispatch_source_t dispatch_timer_default(NSTimeInterval interval, dispatch_block_t handler);

NS_ASSUME_NONNULL_END
