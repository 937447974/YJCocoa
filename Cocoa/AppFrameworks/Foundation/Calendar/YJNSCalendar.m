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

@interface YJNSCalendar() {
    NSInteger _era;
    NSInteger _year;
    NSInteger _month;
    NSInteger _day;
    NSInteger _hour;
    NSInteger _minute;
    NSInteger _second;
    NSInteger _nanosecond;
    NSInteger _weekday;
    NSInteger _weekdayOrdinal;
    NSInteger _quarter;
    NSInteger _weekOfMonth;
    NSInteger _weekOfYear;
    NSInteger _yearForWeekOfYear;
}

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSCalendar *calendar;

@end

@implementation YJNSCalendar

+ (YJNSCalendar *)currentCalendar {
    return [[YJNSCalendar alloc] initWithDate:NSDate.date calendar:NSCalendar.currentCalendar];
}

- (instancetype)initWithDate:(NSDate *)date calendar:(NSCalendar *)calendar {
    self = [super init];
    if (self) {
        _date = date;
        _calendar = calendar;
    }
    return self;
}

- (void)initEra_Year_Month_Day {
    [self.calendar getEra:&_era year:&_year month:&_month day:&_day fromDate:self.date];
}

- (void)initHour_Minute_Second_Nanosecond {
    [self.calendar getHour:&_hour minute:&_minute second:&_second nanosecond:&_nanosecond fromDate:self.date];
}

- (void)initEra_YearForWeekOfYear_WeekOfYear_Weekday {
    [self.calendar getEra:&_era yearForWeekOfYear:&_yearForWeekOfYear weekOfYear:&_weekOfYear weekday:&_weekday fromDate:self.date];
}

#pragma mark - getter
- (NSInteger)era {
    if (_era == 0) [self initEra_Year_Month_Day];
    return _era;
}

- (NSInteger)year {
    if (_year == 0) [self initEra_Year_Month_Day];
    return _year;
}

- (NSInteger)month {
    if (_month == 0) [self initEra_Year_Month_Day];
    return _month;
}

- (NSInteger)day {
    if (_day == 0) [self initEra_Year_Month_Day];
    return _day;
}

#pragma mark
- (NSInteger)hour {
    if (_hour == 0) {
        _hour = [self.calendar component:NSCalendarUnitHour fromDate:self.date];
    }
    return _hour;
}

- (NSInteger)minute {
    if (_minute == 0) [self initHour_Minute_Second_Nanosecond];
    return _minute;
}

- (NSInteger)second {
    if (_second == 0) [self initHour_Minute_Second_Nanosecond];
    return _second;
}

- (NSInteger)nanosecond {
    if (_nanosecond == 0) [self initHour_Minute_Second_Nanosecond];
    return _nanosecond;
}

#pragma mark
- (NSInteger)weekday {
    if (_weekday == 0) [self initEra_YearForWeekOfYear_WeekOfYear_Weekday];
    return _weekday;
}

- (NSInteger)weekdayOrdinal {
    if (_weekdayOrdinal == 0) {
        _weekdayOrdinal = [self.calendar component:NSCalendarUnitWeekdayOrdinal fromDate:self.date];
    }
    return _weekdayOrdinal;
}

- (NSInteger)quarter {
    if (_quarter == 0) {
        _quarter = [self.calendar component:NSCalendarUnitQuarter fromDate:self.date];
    }
    return _quarter;
}

- (NSInteger)weekOfMonth {
    if (_weekOfMonth == 0) {
        _weekOfMonth = [self.calendar component:NSCalendarUnitWeekOfMonth fromDate:self.date];
    }
    return _weekOfMonth;
}

- (NSInteger)weekOfYear {
    if (_weekOfYear == 0) [self initEra_YearForWeekOfYear_WeekOfYear_Weekday];
    return _weekOfYear;
}

- (NSInteger)yearForWeekOfYear {
    if (_yearForWeekOfYear == 0) [self initEra_YearForWeekOfYear_WeekOfYear_Weekday];
    return _yearForWeekOfYear;
}

@end
