//
//  YJCSystem.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/11.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 弱引用*/
#define __weakSelf   __weak __typeof__(self) weakSelf = self;
/** 强引用*/
#define __strongSelf __strong __typeof(self) strongSelf = weakSelf;

/** 主线程运行,同步执行*/
FOUNDATION_EXPORT void dispatch_sync_main(dispatch_block_t block);
/** 主线程运行,异步UI执行*/
FOUNDATION_EXPORT void dispatch_async_main(dispatch_block_t block);

/** 后台运行*/
FOUNDATION_EXPORT void dispatch_async_background(dispatch_block_t block);

/** 主线程延时执行*/
FOUNDATION_EXPORT void dispatch_after_main(int64_t delayInSeconds, dispatch_block_t block);

/** 串行队列执行(同步)*/
// void dispatch_sync_serial(const char *label, dispatch_block_t block);

/** 并发队列执行*/
FOUNDATION_EXPORT void dispatch_async_concurrent(dispatch_block_t block);

NS_ASSUME_NONNULL_END
