//
//  YJDispatchQueue.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/9/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJDispatchQueue.h"
#import "YJSystemMacro.h"
#import <YJCocoa/YJCocoa-Swift.h>

#pragma mark - main queue
void dispatch_sync_main(dispatch_block_t block) {
    dispatch_queue_main_t queue = dispatch_get_main_queue();
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {
        block();
    } else {
        dispatch_sync(queue, block);
    }
}

void dispatch_async_main(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

void dispatch_after_main(NSTimeInterval delayInSeconds, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

#pragma mark - default queue
dispatch_queue_t dispatch_get_default_queue(unsigned long flags) {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, flags);
}

void dispatch_async_default(dispatch_block_t block) {
    dispatch_async(dispatch_get_default_queue(0), block);
}

void dispatch_after_default(NSTimeInterval delayInSeconds, dispatch_block_t block) {
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_default_queue(0), block);
}

#pragma mark - background queue
dispatch_queue_t dispatch_get_background_queue(unsigned long flags) {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, flags);
}

void dispatch_async_background(dispatch_block_t block) {
    dispatch_async(dispatch_get_background_queue(0), block);
}

#pragma mark - serial queue
void dispatch_sync_serial(dispatch_block_t block) {
    [[YJDispatchQueue serial] sync:block];
    
}

#pragma mark - concurrent queue
void dispatch_async_concurrent(dispatch_block_t block) {
    [[YJDispatchQueue concurrent] async:block];
}
