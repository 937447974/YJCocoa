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

// 使用YJNSTimer时，除特殊情况外，外部弱引用YJNSTimer。

/** 计时器NSTimer*/
@interface YJNSTimer : NSObject

@property (nonatomic, copy, readonly) NSString *identifier; ///< 标识符

@property (nonatomic, strong, nullable) id userInfo; ///< 携带的数据
@property (nonatomic) NSTimeInterval timeInterval;   ///< 时间间隔,默认1
@property (nonatomic) NSTimeInterval time;           ///< 当前执行时间
@property (nonatomic) BOOL countdown;                ///< 是否倒计时运行，默认NO（倒计时time=0时停止，正计时time=60*60*24时停止）

@property (nonatomic) YJNSCalendarUnit unitFlags;                           ///< 解析的日期单位
@property (nonatomic, strong, readonly) YJNSDateComponents *dateComponents; ///< 日期组件

/**
 *  初始化
 *
 *  @note 随应用的生命周期存在。注销时，需执行invalidate方法。
 *
 *  @param identifier 标识符
 *
 *  @return YJNSTimer
 */
+ (instancetype)timerStrongWithIdentifier:(nullable NSString *)identifier;

/**
 *  初始化
 *
 *  @note 随当前调用类的生命周期存在。当前VC回收时，YJNSTimer自动回收。
 *
 *  @param identifier 标识符
 *
 *  @return YJNSTimer
 */
+ (instancetype)timerWeakWithIdentifier:(nullable NSString *)identifier;

/**
 *  添加回调监听
 *
 *  @note action实现方式如：-(void)action:(YJNSTimer *)time;
 *        strong初始化会强引用target，weak初始化弱引用tag
 *
 *  @param target 目标类
 *  @param action 目标方法
 *
 */
- (void)addTarget:(id)target action:(SEL)action;

/**
 *  运行
 *
 */
- (void)run;

/**
 *  暂停
 *
 */
- (void)pause;

/**
 *  失效，手动回收YJNSTimer
 *
 *  @note 当前类自动回收
 *
 */
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
