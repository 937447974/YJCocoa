//
//  YJSchedulerIntercept.h
//  Pods-YJScheduler
//
//  Created by CISDI on 2019/1/3.
//

#import <Foundation/Foundation.h>
#import "YJSchedulerHeader.h"

NS_ASSUME_NONNULL_BEGIN

/** 调度器拦截*/
@interface YJSchedulerIntercept : NSObject

@property (nonatomic, weak) id interceptor;
@property (nonatomic, copy) YJSInterceptCanHandler canHandler;
@property (nonatomic, copy) YJSInterceptHandler completionHandler;

- (instancetype)initWithInterceptor:(id)interceptor canHandler:(YJSInterceptCanHandler)canHandler completionHandler:(YJSInterceptHandler)handler;

@end

NS_ASSUME_NONNULL_END
