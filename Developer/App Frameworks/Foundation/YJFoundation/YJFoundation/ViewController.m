//
//  ViewController.m
//  YJFoundation
//
//  Created by 阳君 on 16/5/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJSFoundation.h"
#import "YJCSystem.h"

#define ViewControllerS (ViewController *)[YJSSingletonMC registerStrongSingleton:[ViewController class]]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testLog];
//    [self testSingleton];
    [self testHttp];
//    [self testPerformSelector];
//    [self testTimer];
}

#pragma mark - log
- (void)testLog {
}



#pragma mark - http相关
- (void)testHttp {

}

#pragma mark - 安全执行Selector



@end
