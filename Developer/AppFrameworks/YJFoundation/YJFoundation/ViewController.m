//
//  ViewController.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJDispatch.h"
#import "YJFoundation.h"

#import "YJTestURLSessionTask.h"
#import "YJTestURLRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testSingleton];
//    [self testTimer];
//    [self testCalendar];
    [self testURLSession];
}

#pragma mark - 单例
- (void)testSingleton {
    for (int i = 0; i<100; i++) {
        //异步执行队列任务
        dispatch_async_concurrent(^{
            NSLog(@"%@", [YJNSSingletonMC registerStrongSingleton:[ViewController class]]);
        });
        dispatch_async_concurrent(^{
            NSLog(@"%@", [YJNSSingletonMC registerStrongSingleton:[YJNSSingletonMCenter class]]);
        });
    }
    NSLog(@"dispatch_queue_create");
}

#pragma mark - 倒计时
- (void)testTimer {
    for (int i=0; i<1; i++) {
        YJNSTimer *timer = [YJNSTimer timerWeakWithIdentifier:nil];
        [timer addTarget:self action:@selector(testTimerLog:)];
        timer.unitFlags =  YJNSCalendarUnitDay|YJNSCalendarUnitHour|YJNSCalendarUnitMinute|YJNSCalendarUnitSecond ;
        timer.timeInterval = 3;
        timer.time = 10;
        timer.countdown = YES;
        [timer run];
    }
}

- (void)testTimerLog:(YJNSTimer *)timer {
    NSLog(@"%@ day:%ld; hour:%ld; minute:%ld; second:%.3f;", timer.identifier, (long)timer.dateComponents.day, (long)timer.dateComponents.hour, (long)timer.dateComponents.minute, timer.dateComponents.second);
    // 模拟释放当前VC
    if (timer.time<=0) {
        [timer invalidate];
    }
}

#pragma mark - Calendar
- (void)testCalendar {
    YJNSCalendar *calendar = [[YJNSCalendar alloc] init];
    [calendar components:YJNSCalendarUnitDay | YJNSCalendarUnitHour | YJNSCalendarUnitMinute | YJNSCalendarUnitSecond fromSecond:86400+3600+60+5.98];
    NSLog(@"day:%ld; hour:%ld; minute:%ld; second:%.3f;", (long)calendar.dateComponents.day, (long)calendar.dateComponents.hour, (long)calendar.dateComponents.minute, calendar.dateComponents.second);
}

#pragma mark - URLSession
- (void)testURLSession {
    YJTestURLRequestModel *requestModel = [[YJTestURLRequestModel alloc] init];
    requestModel.name = @"阳君";
    requestModel.qq = @"557445088";
    __weakSelf
    [[[YJTestURLSessionTask taskWithRequest:[YJTestURLRequest requestWithSource:self requestModel:requestModel]] completionHandler:^(id data) {
        __strongSelf
        YJNSURLResponseModel *responseModel = data;
        NSLog(@"获取服务器数据:%@", responseModel.modelDictionary);
        [[YJTestURLSessionTask taskWithRequest:[YJTestURLRequest requestWithSource:strongSelf]] cancel]; // 取消请求
    } failure:^(NSError *error) {
        __strongSelf
        [YJTestURLSessionTask taskWithRequest:[YJTestURLRequest requestWithSource:strongSelf]].request.supportResume = YES; // 开启断网重连
        [YJNSURLSession resumeAllNeedTask];// 断网重连
    }] resume]; // 发出请求
}


@end
