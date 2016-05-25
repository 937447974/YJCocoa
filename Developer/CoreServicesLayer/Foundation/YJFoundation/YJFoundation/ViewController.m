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
#import "YJHttpAnalysis.h"

#define ViewControllerS (ViewController *)[YJSingletonMC registerStrongSingleton:[ViewController class]]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testLog];
//    [self testSingleton];
    [self testHttpAnalysis];
}

#pragma mark - test
#pragma mark log
- (void)testLog {
    NSArray *array = [NSArray arrayWithObjects:@"阳君", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSSet *set = [NSSet setWithObjects:@"937447974", @"阳君", dict, nil];
    array = [NSArray arrayWithObjects:@"阳君", dict, set, nil];
    dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSLog(@"%@", dict);
}

#pragma mark 单例
- (void)testSingleton {
    for (int i = 0; i<100; i++) {
        //异步执行队列任务
        dispatch_async_concurrent(^{
            NSLog(@"%@", ViewControllerS);
        });
        dispatch_async_concurrent(^{
            NSLog(@"%@", [YJSingletonMC registerStrongSingleton:[YJSingletonMCenter class]]);
        });
    }
    NSLog(@"dispatch_queue_create");
}

#pragma mark http解析获取参数
- (void)testHttpAnalysis {
    NSString *http = @"https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&tn=baidu&wd=ios&oq=&rsv_pq=b3c5f2be0002d056&rsv_t=&rqlang=cn&rsv_enter=1&inputT=982&rsv_sug3=12&rsv_sug1=10&rsv_sug7=101&rsv_sug2=0&rsv_sug4=1638&name=阳君";
    NSLog(@"%@", [YJHttpAnalysis analysisParams:http]);
     NSLog(@"%@", [YJHttpAnalysis analysisParams:http forKey:@"name"]);
}

@end
