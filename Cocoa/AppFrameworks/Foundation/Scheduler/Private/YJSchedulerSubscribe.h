//
//  YJSchedulerSubscribe.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/12/29.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJSchedulerHeader.h"

NS_ASSUME_NONNULL_BEGIN

/** 调度器订阅*/
@interface YJSchedulerSubscribe : NSObject

@property (nonatomic, copy) NSString *topic;
@property (nonatomic, weak) id subscriber;
@property (nonatomic) YJSchedulerQueue queue;
@property (nonatomic, copy) YJSSubscribeHandler completionHandler;

- (instancetype)initWithTopic:(NSString *)topic subscriber:(id)subscriber queue:(YJSchedulerQueue)queue completionHandler:(YJSSubscribeHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END

