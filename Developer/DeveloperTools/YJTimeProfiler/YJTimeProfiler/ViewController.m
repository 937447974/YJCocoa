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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YJTimeProfiler.shared.start = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"1");
    for (int i = 0; i < 1000; i ++) {
        NSLog(@"......%d", i);
    }
}

@end
