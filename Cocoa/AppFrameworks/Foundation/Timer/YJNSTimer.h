//
//  YJNSTimer.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/5.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSCalendar.h"

NS_ASSUME_NONNULL_BEGIN

@class YJNSTimer;

typedef void (^ YJNSTimerSuccess)(YJNSTimer *timer);

// 使用YJNSTimer时，除特殊情况外，外部应弱引用YJNSTimer。

/** 计时器NSTimer*/
@interface YJNSTimer : NSObject

@property (nonatomic, copy, readonly) NSString *identifier; ///< 标识符

@property (nonatomic) NSTimeInterval timeInterval;   ///< 时间间隔,默认1
@property (nonatomic) NSTimeInterval time;           ///< 当前执行时间
@property (nonatomic) BOOL countdown;                ///< 是否倒计时运行，默认NO（倒计时time=0时自动失效）

@property (nonatomic) YJNSCalendarUnit unitFlags;                           ///< 解析的日期单位
@property (nonatomic, strong, readonly) YJNSDateComponents *dateComponents; ///< 日期组件

/**
 *  @abstract 初始化
 *
 *  @note 随target的生命周期存在。当target回收时，YJNSTimer自动回收。
 *
 *  @param identifier 唯一标识符
 *  @param target     使用的目标类
 *  @param success block回调监听
 *
 *  @return YJNSTimer
 */
+ (instancetype)timerIdentifier:(nullable NSString *)identifier target:(NSObject *)target completionHandler:(YJNSTimerSuccess)success;

/**
 *  @abstract 运行
 */
- (void)run;

/**
 *  @abstract 暂停
 */
- (void)pause;

/**
 *  @abstract 失效，手动回收YJNSTimer
 *
 *  @note 当前类自动回收
 */
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
