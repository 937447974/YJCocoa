//
//  YJNSCalendar.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/5.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJNSCalendar.h"

@implementation YJNSCalendar

- (YJNSDateComponents *)components:(YJNSCalendarUnit)unitFlags fromDate:(YJNSDate *)date {
    YJNSDateComponents *components = [[YJNSDateComponents alloc] init];
     NSTimeInterval second = date.second; ///< 秒
    if (unitFlags & YJNSCalendarUnitDay) {
        components.day = second / 86400;
        second -= components.day * 86400;
    }
    if (unitFlags & YJNSCalendarUnitHour) {
        components.hour = second / 3600;
        second -= components.hour * 3600;
    }
    if (unitFlags & YJNSCalendarUnitMinute) {
        components.minute = second / 60;
        second -= components.minute * 60;
    }
    if (unitFlags & YJNSCalendarUnitSecond) {
        components.second = second;
    }
    return components;
}

@end
