//
//  YJFoundationTests.m
//  YJFoundationTests
//
//  Created by 阳君 on 2019/6/20.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <YJCocoa/YJCocoa-Swift.h>
#import <YJCocoa/YJDispatchQueue.h>

@interface YJFoundationTests : XCTestCase

@end

@implementation YJFoundationTests

- (void)testCalendar {
    YJCalendar *calendar = YJCalendar.current;
    NSLog(@"era:%ld year:%ld month:%ld day:%ld", calendar.era, calendar.year, calendar.month, calendar.day);
    NSLog(@"hour:%ld minute:%ld second:%ld; nanosecond:%ld", calendar.hour, calendar.minute, calendar.second, calendar.nanosecond);
    NSLog(@"weekday:%ld weekOfYear:%ld; yearForWeekOfYear: %ld", (long)calendar.weekday, (long)calendar.weekOfYear, (long)calendar.yearForWeekOfYear);
}

- (void)testDirectory {
    YJDirectory *director = YJDirectory.shared;
    NSLog(@"homeURL: %@", director.homeURL);
    NSLog(@"documentURL: %@", director.documentURL);
    NSLog(@"libraryURL: %@", director.libraryURL);
    NSLog(@"cachesURL: %@", director.cachesURL);
    NSLog(@"tempURL: %@", director.tempURL);
}

- (void)testURL {
    NSLog(@"%@", [YJURL assemblyParams:nil params:@{@"wd" : @"阳君"} encode:NO]);
    NSLog(@"%@", [YJURL assemblyParams:@"http://www.baidu.com" params:@{} encode:YES]);
    NSLog(@"%@", [YJURL assemblyParams:@"http://www.baidu.com?rsv_sug7=101" params:@{@"wd" : @"阳君"} encode:YES]);
    NSLog(@"%@", [YJURL analysisParams:@"https://www.baidu.com?rsv_sug7=101&wd=%E9%98%B3%E5%90%9B" decode:YES]);
}


@end
