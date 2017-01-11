//
//  ViewController.m
//  YJTimeProfiler
//
//  Created by admin on 2017/1/11.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJTimeProfiler.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [YJTimeProfiler startTimeProfiler];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerRun) userInfo:nil repeats:true];
}

- (void)timerRun {
    NSLog(@"1");
    for (int i = 0; i < 10000; i ++) {
        NSLog(@"......");
    }
}

@end
