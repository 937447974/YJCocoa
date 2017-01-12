//
//  ViewController.m
//  YJLeaks
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "ViewController.h"
#import "YJLeaksViewController.h"
#import "YJLeaks.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [YJLeaks start];
}

- (IBAction)onClickPresent:(id)sender {
    [self presentViewController:[[YJLeaksViewController alloc] init] animated:YES completion:nil];
}

- (IBAction)onClickPush:(id)sender {
    [self.navigationController pushViewController:[[YJLeaksViewController alloc] init] animated:YES];
}

@end
