//
//  YJSTimer.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/5.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJSTimer.h"
#import "NSObject+YJPerformSelector.h"
#import "YJSingletonMCenter.h"
#import "YJRandomization.h"
#import "YJSystem.h"

/** 时间缓存池*/
#define timerDict [YJSingletonMC registerStrongSingleton:[NSMutableDictionary class] forIdentifier:@"YJSTimer"]

@interface YJSTimer ()

@property (nonatomic, copy) NSString *identifier; ///< 标识符

@property (nonatomic) BOOL bPause; ///< 是否暂停
@property (nonatomic) BOOL weakT; ///< 是否弱引用

@property (nonatomic, strong, nullable) id strongTarget; ///< 强引用目标
@property (nonatomic, weak, nullable) id weakTarget;     ///< 弱引用目标
@property (nonatomic, nullable) SEL action;              ///< 目标方法

@end

@implementation YJSTimer

#pragma mark - init
+ (instancetype)timerStrongWithIdentifier:(NSString *)identifier {
    YJSTimer *timer = [self timerWithIdentifier:identifier];
    timer.weakT = NO;
    return timer;
}

+ (instancetype)timerWeakWithIdentifier:(NSString *)identifier {
    YJSTimer *timer = [self timerWithIdentifier:identifier];
    timer.weakT = YES;
    return timer;
}

+ (instancetype)timerWithIdentifier:(NSString *)identifier {
    NSMutableDictionary<NSString *, YJSTimer *> *tDict = timerDict;
    if (tDict.count >= 5) {
        for (YJSTimer *timer in tDict.allValues) {
            if (timer.weakT && !timer.weakTarget) {
                [tDict removeObjectForKey:timer.identifier];
            }
        }
    }
    YJSTimer *timer;
    if (identifier) {
        timer = [timerDict objectForKey:identifier];
    }
    if (!timer) {
        timer = [[YJSTimer alloc] init];
        timer.identifier = identifier;
        timer.timeInterval = 1;
        timer.bPause = YES;
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
    self.bPause = NO;
    self.time = self.time;
}

- (void)pause {
    self.bPause = YES;
}

- (void)invalidate {
    self.bPause = YES;
    [timerDict removeObjectForKey:self.identifier];
}

#pragma mark - getter & setter
- (NSString *)identifier {
    if (!_identifier) {
        _identifier = randomization(5);
    }
    return _identifier;
}

- (void)setTime:(NSTimeInterval)time {
    _time = time;
    if (self.bPause) {
        return;
    }
    if (self.weakT && !self.weakTarget) {
        [timerDict removeObjectForKey:self.identifier];
        return;
    }
    if (time < 0 && self.countdown) {
        return;
    } else if (time > 86400 && !self.countdown) {
        return;
    }
    NSInteger timeC = time;
    _day = timeC / 86400;
    timeC -= _day * 86400;
    _hour = timeC / 3600;
    timeC -= _hour * 3600;
    _minute = timeC / 60;
    _second = time - _day * 86400 - _hour * 3600 - _minute*60;
    if (self.weakTarget) {
        [self.weakTarget performSelector:self.action withObjects:@[self]];
    } else {
        [self.strongTarget performSelector:self.action withObjects:@[self]];
    }
    __weakSelf
    dispatch_after_main(self.timeInterval, ^{
        weakSelf.time = weakSelf.countdown ? weakSelf.time-weakSelf.timeInterval : weakSelf.time+weakSelf.timeInterval;
    });
}

@end
