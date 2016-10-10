//
//  ViewController.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import <YJCocoa/YJCocoa.h>
#import "YJFoundation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testSingleton];
//    [self testTimer];
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
    for (int i=0; i<3; i++) {
        YJNSTimer *timer = [YJNSTimer timerWeakWithIdentifier:nil];
        [timer addTarget:self action:@selector(testTimerLog:)];
        timer.timeInterval = 3;
        timer.time = 10;
        timer.countdown = YES;
        [timer run];
    }
}

- (void)testTimerLog:(YJNSTimer *)timer {
    NSLog(@"%@ day:%ld; hour:%ld; minute:%ld; second:%.3f;", timer.identifier, (long)timer.day, (long)timer.hour, (long)timer.minute, timer.second);
    // 模拟释放当前VC
    if (timer.time<=0) {
        [timer invalidate];
    }
}

@end
