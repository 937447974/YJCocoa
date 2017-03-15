//
//  ViewController.m
//  YJMemoryInfo
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by admin on 2017/3/15.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJMemoryInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@", [YJMemoryInfo new]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
