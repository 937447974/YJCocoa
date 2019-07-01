//
//  ViewController.m
//  YJScheduler
//
//  Created by CISDI on 2018/12/29.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJScheduler.h"

@interface ViewController ()

@end

@implementation ViewController

YJSCHEDULER_LOAD(^{
    [YJSchedulerS subscribeTopic:@"test" subscriber:nil onQueue:YJSchedulerQueueMain completionHandler:^(id data, YJSPublishHandler publishHandler) {
        NSLog(@"subscribe1-%@", data);
        publishHandler(@"data1");
    }];
})

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [YJSchedulerS subscribeTopic:@"test" subscriber:self onQueue:YJSchedulerQueueMain completionHandler:^(id data, YJSPublishHandler publishHandler) {
        NSLog(@"subscribe2-%@", data);
    }];
    [YJSchedulerS publishTopic:@"test" data:@"data2" serial:NO completionHandler:^(id data) {
        NSLog(@"publish1-%@", data);
    }];
    [YJSchedulerS removeSubscribeTopic:nil subscriber:self];
    [YJSchedulerS publishTopic:@"test" data:@"data3" serial:NO completionHandler:^(id data) {
        NSLog(@"publish2-%@", data);
    }];
}

@end
