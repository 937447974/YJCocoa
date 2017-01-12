//
//  YJLeaksViewController.m
//  YJLeaks
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJLeaksViewController.h"

@interface YJLeaksViewController ()

@end

@implementation YJLeaksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (!self.navigationController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
