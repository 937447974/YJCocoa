//
//  ViewController.m
//  YJFoundation
//
//  Created by 阳君 on 2019/6/20.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import <YJCocoa/YJCocoa-Swift.h>
#import <YJCocoa/YJDispatchQueue.h>

@interface ViewController ()
@property (nonatomic, copy) NSString *str; ///<
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self testTimer];
//    [self testSingleton];
//    [self testKVO];
        [self testNotificationCenter];
}

#pragma mark - 倒计时
- (void)testTimer {
    UIViewController *vc = UIViewController.new;
    [[YJTimer alloc] initWithTimeInterval:1 target:vc repeats:YES block:^(id target, YJTimer *timer) {
        NSLog(@"%@ 倒计时 done", target);
    }];
    [YJDispatchQueue afterMainWithDelayInSeconds:5 block:^{
        NSLog(@"%@ 释放", vc);
    }];
}

#pragma mark - 单例
- (void)testSingleton {
    for (int i = 0; i < 30; i++) {
        //异步执行队列任务
        dispatch_async_default(^{
            id obj = [YJSingletonCenter.shared strongSingletonWithAClass:ViewController.class forIdentifier:nil];
            NSLog(@"%@", obj);
        });
        dispatch_async_default(^{
            id obj = [YJSingletonCenter.shared strongSingletonWithAClass:ViewController.class forIdentifier:@"private1"];
            NSLog(@"%@ private1", obj);
        });
        dispatch_async_default(^{
            id obj = [YJSingletonCenter.shared weakSingletonWithAClass:ViewController.class forIdentifier:@"private2"];
            NSLog(@"%@ private2", obj);
        });
        dispatch_async_default(^{
            id obj = [YJSingletonCenter.shared weakSingletonWithAClass:ViewController.class forIdentifier:@"private3"];
            NSLog(@"%@ private3", obj);
        });
        dispatch_async_default(^{
            id obj = [YJSingletonCenter.shared weakSingletonWithAClass:ViewController.class forIdentifier:@"private4"];
            NSLog(@"%@ private4", obj);
        });
        dispatch_async_default(^{
            id obj =  [YJSingletonCenter.shared weakSingletonWithAClass:ViewController.class forIdentifier:@"private5"];
            NSLog(@"%@ private5", obj);
        });
    }
    NSLog(@"dispatch_queue_create");
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
    [target removeObserverBlock:observer forKeyPath:nil];// 全移除
    target.str = @"YJ1";
    [target addObserver:observer forKeyPath:@"str" kvoBlock:^(id oldValue, id newValue) {
        NSLog(@"3-%@-%@", oldValue, newValue);
    }];
    target.str = @"YJ3";
    [target removeObserverBlock:observer forKeyPath:@"str"];// 路径移除
    target.str = @"YJ3";
    [target addObserver:observer forKeyPath:@"str" kvoBlock:^(id oldValue, id newValue) {
        NSLog(@"4-%@-%@", oldValue, newValue);
    }];
    target.str = @"YJ4";
    observer = nil; // 自动移除
    target.str = @"YJ4";
    [target removeObserverBlock:observer forKeyPath:nil];// 重复移除崩溃测试
}

#pragma mark - NotificationCenter
- (void)testNotificationCenter {
    NSObject *test = [NSObject new];
    [YJNotificationCenter addObserver:test name:@"test" using:^(NSNotification *note) {
        NSLog(@"%@", note);
    }];
    [NSNotificationCenter.defaultCenter postNotificationName:@"test" object:nil userInfo:@{@"1":@"1"}];
    dispatch_async_main(^{
        [NSNotificationCenter.defaultCenter postNotificationName:@"test" object:nil userInfo:@{@"1":@"2"}];
    });
}

@end
