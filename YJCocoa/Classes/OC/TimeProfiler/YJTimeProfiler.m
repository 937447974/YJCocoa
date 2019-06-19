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
#import <pthread/pthread.h>
#import <signal.h>
#import "YJDispatchTimer.h"
#import "YJSystemOther.h"
#import "YJThreadLogger.h"

void YJTimeProfilerSingalHandler(int sig) {
    if (sig == SIGUSR1) {
        NSLog(@"[YJCocoa] 捕获主线程耗时代码 : \n%@", [NSThread callStackSymbols]);
    }
}

@interface YJTimeProfiler (){
    CFRunLoopObserverRef _runLoopObserver;
}

@property (nonatomic, strong) YJThreadLogger *threadLogger; ///< 线程日志记录器
@property (nonatomic, strong) dispatch_source_t timeout; ///< 超时计时器

@end

@implementation YJTimeProfiler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.interval = 0.017;
        self.threadLogger = [[YJThreadLogger alloc] init];
    }
    return self;
}

#pragma mark - run
- (void)start {
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFStringRef runLoopMode = kCFRunLoopCommonModes;
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
    CFRelease(_runLoopObserver); // 注意释放，否则会造成内存泄露
}

#pragma mark - private
- (void)runLoopAfterWaiting {
    self.timeout = dispatch_timer_default(self.interval, ^{
        [self runLoopBeforeWaiting];
        NSLog(@"[YJCocoa] 捕获主线程耗时代码 : %@", self.threadLogger.log);
    });
}

- (void)runLoopBeforeWaiting {
    if (self.timeout) {
        dispatch_source_cancel(self.timeout);
        self.timeout = nil;
    }
}

@end

