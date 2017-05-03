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

- (instancetype)init {
    self = [super init];
    if (self) {
        _dateComponents = [[YJNSDateComponents alloc] init];
    }
    return self;
}

- (void)components:(YJNSCalendarUnit)unitFlags fromSecond:(NSTimeInterval)second {
    self.dateComponents.day = unitFlags & YJNSCalendarUnitDay ? second / 86400 : 0;
    second -= self.dateComponents.day * 86400;
    
    self.dateComponents.hour = unitFlags & YJNSCalendarUnitHour ? second / 3600 : 0;
    second -= self.dateComponents.hour * 3600;
    
    self.dateComponents.minute = unitFlags & YJNSCalendarUnitMinute ? second / 60 : 0;
    second -= self.dateComponents.minute * 60;
    
    self.dateComponents.second = unitFlags & YJNSCalendarUnitSecond ? second : 0;
}

@end
