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
#import "YJNSDate.h"
#import "YJNSDateComponents.h"

NS_ASSUME_NONNULL_BEGIN

/** 日历单位*/
typedef NS_ENUM(NSInteger, YJNSCalendarUnit) {
    YJNSCalendarUnitDay    = 1,    ///< 天
    YJNSCalendarUnitHour   = 1<<1, ///< 时
    YJNSCalendarUnitMinute = 1<<2, ///< 分
    YJNSCalendarUnitSecond = 1<<3  ///< 秒
};

/** 日历*/
@interface YJNSCalendar : NSObject

/**
 *  @abstract 提取日期相关数据
 *
 *  @param unitFlags 日历单位，如YJNSCalendarUnitDay|YJNSCalendarUnitHour.
 *  @param date YJNSCalendarUnit
 *
 *  @return YJNSDateComponents
 */
- (YJNSDateComponents *)components:(YJNSCalendarUnit)unitFlags fromDate:(YJNSDate *)date;

@end

NS_ASSUME_NONNULL_END


