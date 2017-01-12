//
//  YJTimeProfiler.m
//  YJTimeProfiler
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/11.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJTimeProfiler.h"
#import "YJDispatch.h"
#include <pthread/pthread.h>
#include <signal.h>

void YJTimeProfilerSingalHandler(int sig) {
    if (sig == SIGUSR1) {
        NSLog(@"\n%@", [NSThread callStackSymbols]);
    }
}

@interface YJTimeProfiler ()

@property (nonatomic) pthread_t pthreadMain; ///< 主线程
@property (nonatomic, strong) dispatch_source_t requestTimer;   ///< 请求计时器
@property (nonatomic, strong) dispatch_source_t requestTimeout; ///< 请求超时计时器

@end

@implementation YJTimeProfiler

+ (YJTimeProfiler *)shared {
    static YJTimeProfiler *tp;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signal(SIGUSR1, YJTimeProfilerSingalHandler);
        tp = [[YJTimeProfiler alloc] init];
        tp.pthreadMain = pthread_self();
        tp.frequency = 1;
        tp.interval = 0.17;
    });
    return tp;
}

#pragma mark - start
- (void)start {
    self.requestTimer = dispatch_timer_default(self.frequency, ^{
        [self request];
    });
}

- (void)request {
    self.requestTimeout = dispatch_timer_default(self.interval, ^{
        [self cancelRequestTimeout];
        pthread_kill(self.pthreadMain, SIGUSR1);
    });
    dispatch_async_main(^{
        [self cancelRequestTimeout];
    });
}

#pragma mark - cancel
- (void)cancel {
    [self cancelRequestTimer];
    [self cancelRequestTimeout];
}

- (void)cancelRequestTimer {
    if (self.requestTimer) {
        dispatch_source_cancel(self.requestTimer);
        self.requestTimer = nil;
    }
}

- (void)cancelRequestTimeout {
    if (self.requestTimeout) {
        dispatch_source_cancel(self.requestTimeout);
        self.requestTimeout = nil;
    }
}

@end

