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
#import <pthread/pthread.h>
#import <signal.h>
#import "YJThreadLogger.h"

// 是否断点模式
#define YJTimeProfilerDebug 1

void YJTimeProfilerSingalHandler(int sig) {
    if (sig == SIGUSR1) {
        NSLog(@"\nYJTimeProfiler捕获主线程耗时代码 : \n%@", [NSThread callStackSymbols]);
    }
}

@interface YJTimeProfiler ()
{
    CFRunLoopObserverRef _runLoopObserver;
}

@property (nonatomic) pthread_t pthreadMain; ///< 主线程
@property (nonatomic, strong) YJThreadLogger *threadLogger; ///< 线程日志记录器

@property (nonatomic, strong) dispatch_source_t timeout; ///< 超时计时器

@end

@implementation YJTimeProfiler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frequency = 1;
        self.interval = 0.17;
#if YJTimeProfilerDebug
        signal(SIGUSR1, YJTimeProfilerSingalHandler);
        self.pthreadMain = pthread_self();
#else
        self.threadLogger = [[YJThreadLogger alloc] init];
#endif
    }
    return self;
}


#pragma mark - setter
- (void)setStart:(BOOL)start {
    _start = start;
#if DEBUG
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFStringRef runLoopMode = kCFRunLoopCommonModes;
    if (start) {
        @weakSelf
        _runLoopObserver = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            @strongSelf
            if (activity == kCFRunLoopBeforeWaiting) {
                [self runLoopBeforeWaiting];
            } else if (activity == kCFRunLoopAfterWaiting) {
                [self runLoopAfterWaiting];
            }
        });
        CFRunLoopAddObserver(runLoop, _runLoopObserver, runLoopMode);
    } else {
        if (_runLoopObserver) {
            [self runLoopBeforeWaiting];
            CFRunLoopRemoveObserver(runLoop, _runLoopObserver, runLoopMode);
            CFRelease(_runLoopObserver); // 注意释放，否则会造成内存泄露
        }
    }
#endif
}

#pragma mark - private
- (void)runLoopAfterWaiting {
    NSLog(@"YJTimeProfiler main queue start");
    self.timeout = dispatch_timer_default(self.interval, ^{
        [self runLoopBeforeWaiting];
#if YJTimeProfilerDebug
        pthread_kill(self.pthreadMain, SIGUSR1);
#else
        NSLog(@"\nYJTimeProfiler捕获主线程耗时代码 : \n%@", self.threadLogger.log);
#endif
    });
}

- (void)runLoopBeforeWaiting {
    NSLog(@"YJTimeProfiler main queue end");
    if (self.timeout) {
        dispatch_source_cancel(self.timeout);
        self.timeout = nil;
    }
}

@end

