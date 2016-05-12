//
//  ViewController.m
//  YJCocoa
//
//  Created by 阳君 on 16/5/11.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJCocoa.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@", YJStringFromClass(self.class));
//    dispatch_async(<#dispatch_queue_t queue#>, <#^(void)block#>)
    NSLog(@"2");
    dispatch_after_main(1, ^{
        NSLog(@"1");
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
