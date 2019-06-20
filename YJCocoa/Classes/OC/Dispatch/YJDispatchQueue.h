//
//  YJDispatchQueue.h
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

#pragma mark - main queue
/** main queue 同步执行 **/
DISPATCH_EXPORT void dispatch_sync_main(dispatch_block_t block);
/** main queue 异步执行 **/
DISPATCH_EXPORT void dispatch_async_main(dispatch_block_t block);
/** main queue 延时执行*/
DISPATCH_EXPORT void dispatch_after_main(NSTimeInterval delayInSeconds, dispatch_block_t block);

#pragma mark - default queue
/** default queue get*/
DISPATCH_EXPORT dispatch_queue_t dispatch_get_default_queue(unsigned long flags);
/** default queue 异步执行 **/
DISPATCH_EXPORT void dispatch_async_default(dispatch_block_t block);
/** default queue 延时执行*/
DISPATCH_EXPORT void dispatch_after_default(NSTimeInterval delayInSeconds, dispatch_block_t block);

#pragma mark - background queue
/** background queue get*/
DISPATCH_EXPORT dispatch_queue_t dispatch_get_background_queue(unsigned long flags);
/** background queue 异步执行（I/O） **/
DISPATCH_EXPORT void dispatch_async_background(dispatch_block_t block);

NS_ASSUME_NONNULL_END
