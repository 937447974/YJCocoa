//
//  YJSchedulerHeader.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/12/29.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#ifndef YJSchedulerHeader_h
#define YJSchedulerHeader_h
#import "YJCodeInject.h"

/** 调度器订阅、拦截加载*/
#define YJSCHEDULER_LOAD(block) YJCI_BLOCK_EXPORT(YJSchedulerLoad, block)

/** 发布后执行方处理完毕的回调*/
typedef void (^ YJSPublishHandler)(id _Nullable data);
/** 订阅回调*/
typedef void (^ YJSSubscribeHandler)(id _Nullable data, YJSPublishHandler _Nullable publishHandler);
/** 能否拦截*/
typedef BOOL (^ YJSInterceptCanHandler)(NSString *topic);
/** 拦截回调*/
typedef BOOL (^ YJSInterceptHandler)(NSString *topic, id _Nullable data, YJSPublishHandler _Nullable publishHandler);


/** 调度队列*/
typedef NS_ENUM(NSInteger, YJSchedulerQueue) {
    YJSchedulerQueueMain,       ///< 主队列
    YJSchedulerQueueDefault     ///< 子队列
};

#endif /* YJSchedulerHeader_h */
