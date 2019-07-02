//
//  ViewController.m
//  YJTimeline
//
//  Created by CISDI on 2019/1/19.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import <YJCocoa/YJTimeline.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [YJTimeline addSteps:@"ViewController-viewDidLoad"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [YJTimeline addSteps:@"ViewController-viewDidLoad"];
}

@end
