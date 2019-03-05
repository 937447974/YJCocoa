//
//  ViewController.m
//  YJCodeInject
//
//  Created by 阳君 on 2019/3/5.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJCodeInject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [YJCodeInject executeFunctionForKey:@"A"];
    [YJCodeInject executeFunctionForKey:@"B"];
    [YJCodeInject executeBlockForKey:@"A"];
    [YJCodeInject executeBlockForKey:@"B"];
}


@end
