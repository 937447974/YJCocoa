//
//  YJNSTimer.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/5.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSTimer.h"
#import "NSObject+YJNSPerformSelector.h"
#import "YJNSSingleton.h"
#import "YJSecRandom.h"

/** 时间缓存池*/
#define TimerDict YJNSSingletonS(NSMutableDictionary, @"YJNSTimer")

@interface YJNSTimer ()

@property (nonatomic, copy) NSString *identifier; ///< 标识符

@property (nonatomic, weak) id target;                ///< 弱引用目标
@property (nonatomic, copy) YJNSTimerSuccess success; ///< 成功回调

@property (nonatomic, strong) NSTimer *timer;         ///< 计时器
@property (nonatomic, strong) YJNSCalendar *calendar; ///< 日历

@end

@implementation YJNSTimer

#pragma mark - init
+ (instancetype)timerIdentifier:(NSString *)identifier target:(NSObject *)target completionHandler:(YJNSTimerSuccess)success {
    identifier = identifier.length ? identifier : YJSecRandomUL(5);
    NSMutableDictionary<NSString *, YJNSTimer *> *tDict = TimerDict;
    YJNSTimer *timer = [tDict objectForKey:identifier];
    if (!timer) {
        timer = [[YJNSTimer alloc] init];
        timer.identifier = identifier;
        timer.timeInterval = 1;
        timer.calendar = [[YJNSCalendar alloc] init];
    }
    [tDict setObject:timer forKey:timer.identifier];
    timer.target = target;
    timer.success = success;
    return timer;
}

#pragma mark - business
- (void)run {
    NSAssert(self.timeInterval > 0, @"YJNSTimer.timeInterval小于等于0");
    if (!self.timer || self.timer.timeInterval != self.timeInterval) {
        self.timer = [NSTimer timerWithTimeInterval:self.timeInterval target:self selector:@selector(autoUpdateTime) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    } else {
        self.timer.fireDate = [NSDate date];
    }
}

- (void)autoUpdateTime {
    if (!self.target) {
        [self invalidate];
        return;
    }
    if (self.countdown) {
        NSTimeInterval time = self.time - self.timeInterval;
        if (time <= 0) {
            [self invalidate];
            time = 0;
        }
        self.time = time;
    } else {
        self.time = self.time + self.timeInterval;
    }
}

- (void)pause {
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)invalidate {
    [self.timer invalidate];
    self.timer = nil;
    [TimerDict removeObjectForKey:self.identifier];
}

#pragma mark - getter & setter
- (void)setTime:(NSTimeInterval)time {
    _time = time;
    if (self.unitFlags) {
        [self.calendar components:self.unitFlags fromSecond:time];
    }
    self.success(self);
}

- (YJNSDateComponents *)dateComponents {
    return self.calendar.dateComponents;
}

@end
