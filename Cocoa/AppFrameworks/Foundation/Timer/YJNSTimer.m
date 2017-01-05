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
#import "YJNSSingletonMCenter.h"
#import "YJSecRandom.h"

/** 时间缓存池*/
#define timerDict [YJNSSingletonMC registerStrongSingleton:[NSMutableDictionary class] forIdentifier:@"YJNSTimer"]

@interface YJNSTimer ()

@property (nonatomic, copy) NSString *identifier; ///< 标识符

@property (nonatomic) BOOL weakT; ///< 是否弱引用

@property (nonatomic, strong, nullable) id strongTarget; ///< 强引用目标
@property (nonatomic, weak, nullable) id weakTarget;     ///< 弱引用目标
@property (nonatomic, nullable) SEL action;              ///< 目标方法

@property (nonatomic, strong) NSTimer *timer; /// 计时器
@property (nonatomic, strong) YJNSCalendar *calendar; ///<

@end

@implementation YJNSTimer

#pragma mark - init
+ (instancetype)timerStrongWithIdentifier:(NSString *)identifier {
    YJNSTimer *timer = [self timerWithIdentifier:identifier];
    timer.weakT = NO;
    return timer;
}

+ (instancetype)timerWeakWithIdentifier:(NSString *)identifier {
    YJNSTimer *timer = [self timerWithIdentifier:identifier];
    timer.weakT = YES;
    return timer;
}

+ (instancetype)timerWithIdentifier:(NSString *)identifier {
    NSMutableDictionary<NSString *, YJNSTimer *> *tDict = timerDict;
    if (tDict.count >= 5) {
        for (YJNSTimer *timer in tDict.allValues) {
            if (timer.weakT && !timer.weakTarget) {
                [tDict removeObjectForKey:timer.identifier];
            }
        }
    }
    YJNSTimer *timer;
    if (identifier) {
        timer = [timerDict objectForKey:identifier];
    }
    if (!timer) {
        timer = [[YJNSTimer alloc] init];
        timer.identifier = identifier;
        timer.timeInterval = 1;
        timer.calendar = [[YJNSCalendar alloc] init];
    }
    [tDict setObject:timer forKey:timer.identifier];
    return timer;
}

#pragma mark - business
- (void)addTarget:(id)target action:(SEL)action {
    self.action = action;
    if (self.weakT) {
        self.weakTarget = target;
    } else {
        self.strongTarget = target;
    }
}

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
    if (self.weakT && !self.weakTarget) {
        [self invalidate];
        return;
    }
    if (self.time <= 0 && self.countdown) {
        [self pause];
        return;
    } else if (self.time >= 86400 && !self.countdown) {
        [self pause];
        return;
    }
    self.time = self.countdown ? self.time-self.timeInterval : self.time+self.timeInterval;
}

- (void)pause {
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)invalidate {
    [self.timer invalidate];
    self.timer = nil;
    [timerDict removeObjectForKey:self.identifier];
}

#pragma mark - getter & setter
- (NSString *)identifier {
    if (!_identifier) {
        _identifier = YJSecRandomUL(5);
    }
    return _identifier;
}

- (void)setTime:(NSTimeInterval)time {
    _time = time;
    if (self.unitFlags) {
        [self.calendar components:self.unitFlags fromSecond:time];
    }
    if (self.weakTarget) {
        [self.weakTarget performSelector:self.action withObjects:@[self]];
    } else {
        [self.strongTarget performSelector:self.action withObjects:@[self]];
    }
}

- (YJNSDateComponents *)dateComponents {
    return self.calendar.dateComponents;
}

@end
