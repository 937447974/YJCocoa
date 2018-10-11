//
//  YJNSCalendar.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/5.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 日历*/
@interface YJNSCalendar : NSObject

@property (nonatomic, class, readonly, copy) YJNSCalendar *currentCalendar;///< 当前时间

@property (nonatomic, readonly) NSInteger era;  ///< NSDateComponents.era
@property (nonatomic, readonly) NSInteger year; ///< NSDateComponents.year
@property (nonatomic, readonly) NSInteger month;///< NSDateComponents.month
@property (nonatomic, readonly) NSInteger day;///< NSDateComponents.day

@property (nonatomic, readonly) NSInteger hour;///< NSDateComponents.hour
@property (nonatomic, readonly) NSInteger minute;///< NSDateComponents.minute
@property (nonatomic, readonly) NSInteger second;///< NSDateComponents.second
@property (nonatomic, readonly) NSInteger nanosecond;///< NSDateComponents.nanosecond

@property (nonatomic, readonly) NSInteger weekday;///< NSDateComponents.weekday
@property (nonatomic, readonly) NSInteger weekdayOrdinal;///< NSDateComponents.weekdayOrdinal
@property (nonatomic, readonly) NSInteger quarter;///< NSDateComponents.quarter
@property (nonatomic, readonly) NSInteger weekOfMonth;///< NSDateComponents.weekOfMonth
@property (nonatomic, readonly) NSInteger weekOfYear;///< NSDateComponents.weekOfYear
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;///< NSDateComponents.yearForWeekOfYear

/**
 *  @abstract 初始化
 *
 *  @param date NSDate
 *  @param calendar NSCalendar
 *
 *  @return instancetype
 */
- (instancetype)initWithDate:(NSDate *)date calendar:(NSCalendar *)calendar;

@end

NS_ASSUME_NONNULL_END


