//
//  ViewController.m
//  YJFoundation
//
//  Created by 阳君 on 16/5/16.
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
//    [self testHttp];
//    [self testPerformSelector];
    [self testTimer];
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

#pragma mark - http相关
- (void)testHttp {
    NSString *http = [YJHttpAssembly assemblyHttp:@"https://www.baidu.com/s" params:@{@"name":@"阳君", @"qq":@"937447974"}];
    NSLog(@"%@", http);
    NSLog(@"%@", [YJHttpAnalysis analysisParams:http]);
    NSLog(@"%@", [YJHttpAnalysis analysisParams:http forKey:@"name"]);
}

#pragma mark - 安全执行Selector
- (void)testPerformSelector {
    [self performSelector:@selector(testPerformSelector1) withObjects:nil];
    [self performSelector:@selector(testPerformSelector2:withObject:withObject:) withObjects:@[@"1",@"2"]];
    YJPerformSelector *result = [self performSelector:@selector(testPerformSelector3:withObject:) withObjects:@[@"1",@"2"]];
    NSLog(@"%@", result.result);
}

- (void)testPerformSelector1 {
    NSLog(NSStringFromSelector(_cmd), nil);
}

- (void)testPerformSelector2:(id)object0 withObject:(id)object1 withObject:(id)object2 {
    NSLog(@"0:%@; 1:%@; 2:%@", object0, object1, object2);
}

- (NSString *)testPerformSelector3:(id)object1 withObject:(id)object2 {
    NSLog(@"0:%@; 1:%@; ", object1, object2);
    return @"阳君";
}

#pragma mark - 
- (void)testTimer {
    UITableView;
    UIButton *c;
    c addTarget:<#(nullable id)#> action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>
    
}

@end
