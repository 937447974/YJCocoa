//
//  YJDispatchTimer.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/9/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJDispatchTimer.h"

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
    dispatch_queue_global_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    return dispatch_timer(queue, interval, handler);
}
