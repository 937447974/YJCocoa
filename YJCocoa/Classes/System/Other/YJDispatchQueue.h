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

#pragma mark - serial queue
/** serial queue 同步执行*/
DISPATCH_EXPORT void dispatch_sync_serial(dispatch_block_t block);

#pragma mark - concurrent queue
/** concurrent queue 异步执行*/
DISPATCH_EXPORT void dispatch_async_concurrent(dispatch_block_t block);

NS_ASSUME_NONNULL_END
