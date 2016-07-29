//
//  ViewController.m
//  YJSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJSecurity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testRadom];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testRadom {
    NSString *result = randomizationUppercase(32);
    NSLog(result, nil);
    result = randomizationLowercase(32);
    NSLog(result, nil);
    result = randomization(32);
    NSLog(result, nil);
    NSLog(@"%lu", result.length);
}

@end
