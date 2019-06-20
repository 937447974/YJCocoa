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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self testTimer];
//    [self testSingleton];
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


@end
