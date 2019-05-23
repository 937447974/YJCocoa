//
//  YJNSCalendar.swift
//  Pods
//
//  Created by 阳君 on 2019/5/9.
//

import Foundation

///  日历
open class YJNSCalendar: NSObject {
    
    /// 当前时间
    public class var current: YJNSCalendar {
        return YJNSCalendar(date: NSDate(timeIntervalSinceNow: 0), calendar: NSCalendar.current as NSCalendar)
    }
    
    /// NSDateComponents.era
    public var era: NSInteger {
        self.getEraYearMonthDay()
        return self._era
    }
    /// NSDateComponents.year
    public var year: NSInteger {
        self.getEraYearMonthDay()
        return self._year
    }
    /// NSDateComponents.month
    public var month: NSInteger {
        self.getEraYearMonthDay()
        return self._month
    }
    /// NSDateComponents.day
    public var day: NSInteger {
        self.getEraYearMonthDay()
        return self._day
    }
    /// NSDateComponents.hour
    public var hour: NSInteger {
        self.getHourMinuteSecondNanosecond()
        return self._hour
    }
    /// NSDateComponents.minute
    public var minute: NSInteger {
        self.getHourMinuteSecondNanosecond()
        return self._minute
    }
    /// NSDateComponents.second
    public var second: NSInteger {
        self.getHourMinuteSecondNanosecond()
        return self._second
    }
    /// NSDateComponents.nanosecond
    public var nanosecond: NSInteger {
        self.getHourMinuteSecondNanosecond()
        return self._nanosecond
    }
    /// NSDateComponents.yearForWeekOfYear
    public var yearForWeekOfYear: NSInteger {
        self.getYearForWeekOfYearWeekOfYearWeekday()
        return self._yearForWeekOfYear
    }
    /// NSDateComponents.weekOfYear
    public var weekOfYear: NSInteger {
        self.getYearForWeekOfYearWeekOfYearWeekday()
        return self._weekOfYear
    }
    /// NSDateComponents.weekday
    public var weekday: NSInteger {
        self.getYearForWeekOfYearWeekOfYearWeekday()
        return self._weekday
    }
    
    private var date: NSDate!
    private var calendar: NSCalendar!
    private var _era = 0
    private var _year = 0
    private var _month = 0
    private var _day = 0
    private var _hour = 0
    private var _minute = 0
    private var _second = 0
    private var _nanosecond = 0
    private var _weekday = 0
    private var _weekOfYear = 0
    private var _yearForWeekOfYear = 0
    
    
    /// 初始化
    public init(date: NSDate, calendar: NSCalendar) {
        super.init()
        self.date = date
        self.calendar = calendar
    }
    
    func getEraYearMonthDay() {
        if self._era > 0 || self._year > 0 || self._month > 0 || self._day > 0 {
            return
        }
        self.calendar.getEra(&_era, year: &_year, month: &_month, day: &_day, from: self.date as Date)
    }
    
    func getHourMinuteSecondNanosecond() {
        if self._hour > 0 || self._minute > 0 || self._second > 0 || self._nanosecond > 0 {
            return
        }
        self.calendar.getHour(&_hour, minute: &_minute, second: &_second, nanosecond: &_nanosecond, from: self.date as Date)
    }
    
    func getYearForWeekOfYearWeekOfYearWeekday() {
        if self._yearForWeekOfYear > 0 || self._weekOfYear > 0 || self._weekday > 0{
            return
        }
        self.calendar.getEra(nil, yearForWeekOfYear: &_yearForWeekOfYear, weekOfYear: &_weekOfYear, weekday: &_weekday, from: self.date as Date)
    }
    
}
