//
//  ViewController.m
//  YJFoundation
//
//  Created by admin on 2016/10/10.
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


@end
