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
#import "YJTestURLRequestModel.h"
#import "YJNSURLResponseModel.h"

@interface ViewController ()

@property (nonatomic, copy) NSString *str; ///<

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //        [self testSingleton];
    //        [self testTimer];
    //        [self testCalendar];
            [self testURLSession];
    //    [self testSwizzling];
    //    [self testLog];
//    [self testKVO];
}

#pragma mark - log
- (void)testLog {
    NSArray *array = [NSArray arrayWithObjects:@"阳君", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSSet *set = [NSSet setWithObjects:@"937447974", @"阳君", dict, nil];
    array = [NSArray arrayWithObjects:@"阳君", dict, set, nil];
    dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSLog(@"%@", dict);
}

#pragma mark - 单例
- (void)testSingleton {
    for (int i = 0; i<10; i++) {
        //异步执行队列任务
        dispatch_async_default(^{
            NSLog(@"0-%@", YJNSSingletonS(ViewController, nil));
        });
        dispatch_async_default(^{
            NSLog(@"1- %@", YJNSSingletonS(ViewController, @"private"));
        });
        dispatch_async_default(^{
            NSLog(@"2-  %@", YJNSSingletonW(ViewController, nil));
        });
        dispatch_async_default(^{
            NSLog(@"3-   %@", YJNSSingletonW(ViewController, @"private"));
        });
    }
    NSLog(@"dispatch_queue_create");
}

#pragma mark - 倒计时
- (void)testTimer {
    for (int i=0; i<1; i++) {
        YJNSTimer *timer = [YJNSTimer timerIdentifier:nil target:self completionHandler:^(YJNSTimer *timer) {
            NSLog(@"%@ day:%ld; hour:%ld; minute:%ld; second:%.3f;", timer.identifier, (long)timer.dateComponents.day, (long)timer.dateComponents.hour, (long)timer.dateComponents.minute, timer.dateComponents.second);
        }];
        timer.unitFlags =  YJNSCalendarUnitDay|YJNSCalendarUnitHour|YJNSCalendarUnitMinute|YJNSCalendarUnitSecond ;
        timer.timeInterval = 3;
        timer.time = 10;
        timer.countdown = YES;
        [timer run];
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
    YJNSURLRequest *request = [YJNSURLRequest requestWithSource:nil url:@"https://github.com/937447974/YJCocoa" reqMethod:YJNSURLRequestMethodPOST reqModel:requestModel respModelClass:YJNSURLResponseModel.class];
    [[[YJTestURLSessionTask taskWithRequest:request] completionHandler:^(YJNSURLResponseModel *responseModel) {
        NSLog(@"获取服务器数据:%@", responseModel.modelDictionary);
        [[YJTestURLSessionTask taskWithRequest:request] cancel]; // 取消请求        
    } failure:^(NSError *error) {
        request.supportResume = YES; // 开启断网重连
        [YJNSURLSession resumeAllNeedTask];// 断网重连
    }] resume]; // 发出请求
}

#pragma mark - Swizzling
- (void)testSwizzling {
    /*
     // 分组多线程交换测试
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
     dispatch_group_t group = dispatch_group_create();
     for (int i = 0; i < 20; i++) {
     dispatch_group_async(group, queue, ^{
     NSLog(@"dispatch_group_async:%d", i);
     [self.class swizzlingSEL:@selector(testSwizzlingInstance) withSEL:@selector(swizzling_testSwizzlingInstance)];
     });
     }
     dispatch_group_notify(group, queue, ^{
     NSLog(@"dispatch_group_notify");
     [self testSwizzlingInstance];
     // 多次交换
     [self.class swizzlingSEL:@selector(testSwizzlingInstance) withSEL:@selector(swizzling_testSwizzlingInstance)];
     [self testSwizzlingInstance];
     [self.class swizzlingSEL:@selector(swizzling_testSwizzlingInstance) withSEL:@selector(testSwizzlingInstance)];
     [self testSwizzlingInstance];
     });
     */
    // class方法交换
    [self.class swizzlingClassSEL:@selector(testSwizzlingClass) withSEL:@selector(swizzling_testSwizzlingClass)];
    [self.class testSwizzlingClass];
}

- (void)testSwizzlingInstance {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)swizzling_testSwizzlingInstance{
    [self swizzling_testSwizzlingInstance];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)testSwizzlingClass {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

+ (void)swizzling_testSwizzlingClass {
    [self swizzling_testSwizzlingClass];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - KVO
- (void)testKVO {
    ViewController *target = [ViewController new];
    ViewController *observer = [ViewController new];
    [target addObserver:observer forKeyPath:@"str" kvoBlock:^(id oldValue, id newValue) {
        NSLog(@"1-%@-%@", oldValue, newValue);
    }];
    [target addObserver:observer forKeyPath:@"str" kvoBlock:^(id oldValue, id newValue) {
        NSLog(@"2-%@-%@", oldValue, newValue);
    }];
    target.str = @"YJ";
    target.str = @"YJ";
    [target removeKVObserver:observer forKeyPath:nil];// 全移除
    target.str = @"YJ1";
    [target addObserver:observer forKeyPath:@"str" kvoBlock:^(id oldValue, id newValue) {
        NSLog(@"3-%@-%@", oldValue, newValue);
    }];
    target.str = @"YJ3";
    [target removeKVObserver:observer forKeyPath:@"str"];// 路径移除
    target.str = @"YJ3";
    [target addObserver:observer forKeyPath:@"str" kvoBlock:^(id oldValue, id newValue) {
        NSLog(@"4-%@-%@", oldValue, newValue);
    }];
    target.str = @"YJ4";
    observer = nil; // 自动移除
    target.str = @"YJ4";
    [target removeKVObserver:observer forKeyPath:nil];// 重复移除崩溃测试
}

@end
