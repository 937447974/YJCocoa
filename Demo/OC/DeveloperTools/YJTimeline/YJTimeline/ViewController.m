//
//  ViewController.m
//  YJTimeline
//
//  Created by CISDI on 2019/1/19.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import <YJCocoa/YJCocoa-Swift.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [YJTimeline addWithStep:@"ViewController-viewDidLoad"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [YJTimeline addWithStep:@"ViewController-viewDidLoad"];
}

@end
