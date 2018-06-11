//
//  NSNotificationCenter+YJ.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/6/11.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 通知中心 block 回调*/
@interface NSNotificationCenter (YJ)

/**
 *  @abstract Adds an entry to the notification center's dispatch table with an observer and a block, and an optional notification name.
 *
 *  @param observer Object registering as an observer.
 *  @param name The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
 *  @param block The block to be executed when the notification is received.
 */
- (void)addObserver:(NSObject *)observer name:(NSNotificationName)name usingBlock:(void (^)(NSNotification *note))block;

@end

NS_ASSUME_NONNULL_END
