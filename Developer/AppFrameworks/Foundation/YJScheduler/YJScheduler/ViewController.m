//
//  ViewController.m
//  YJScheduler
//
//  Created by CISDI on 2018/12/29.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJScheduler.h"

@interface ViewController () <YJSchedulerProtocol>

@end

@implementation ViewController

+ (void)schedulerLoad {
    [YJSchedulerS subscribeTopic:@"test" subscriber:nil onQueue:YJSchedulerQueueMain completionHandler:^(id data, YJSPublishHandler publishHandler) {
        NSLog(@"%@", data);
        publishHandler(@"111");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [YJSchedulerS publishTopic:@"test" data:@"test" serial:NO completionHandler:^(id data) {
        NSLog(@"%@", data);
    }];
}

@end
