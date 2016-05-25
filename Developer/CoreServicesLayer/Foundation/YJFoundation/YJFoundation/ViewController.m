//
//  ViewController.m
//  YJFoundation
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJFoundation.h"
#import "YJSystem.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testLog];
    [self testSingleton];
}

#pragma mark - test
- (void)testLog {
    NSArray *array = [NSArray arrayWithObjects:@"阳君", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSSet *set = [NSSet setWithObjects:@"937447974", @"阳君", dict, nil];
    array = [NSArray arrayWithObjects:@"阳君", dict, set, nil];
    dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSLog(@"%@", dict);
}

- (void)testSingleton {
    // 串行队列：只有一个线程，加入到队列中的操作按添加顺序依次执行。
    for (int i = 0; i<100; i++) {
        //异步执行队列任务
        dispatch_async_concurrent(^{
            NSLog(@"%@", [YJSingletonMC registerStrongSingleton:self.class]);
        });
        dispatch_async_concurrent(^{
            NSLog(@"%@", [YJSingletonMC registerStrongSingleton:[YJSingletonMCenter class]]);
        });
    }
    NSLog(@"dispatch_queue_create");
}

@end
