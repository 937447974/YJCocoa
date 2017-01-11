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
        NSLog(@"%@\n", [NSThread callStackSymbols]);
    }
}

@interface YJTimeProfiler ()

@property (nonatomic) pthread_t pthreadMain; ///< 主线程
@property (nonatomic, strong) dispatch_source_t pingTimer;
@property (nonatomic, strong) dispatch_source_t pingTimeout;

@end

@implementation YJTimeProfiler

+ (void)startTimeProfiler {
    static YJTimeProfiler *tp;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tp = [[YJTimeProfiler alloc] init];
    });
    dispatch_async_main(^{
        signal(SIGUSR1, YJTimeProfilerSingalHandler);
        tp.pthreadMain = pthread_self();
        tp.pingTimer = dispatch_timer(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), 1, ^{
            [tp ping];
        });
    });
}

- (void)ping {
    self.pingTimeout = dispatch_timer(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), 0.16, ^{
        [self cancelPingTimeout];
        pthread_kill(self.pthreadMain, SIGUSR1);
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        [self cancelPingTimeout];
    });
}

- (void)cancelPingTimeout {
    if (self.pingTimeout) {
        dispatch_source_cancel(self.pingTimeout);
        self.pingTimeout = nil;
    }
}

@end
