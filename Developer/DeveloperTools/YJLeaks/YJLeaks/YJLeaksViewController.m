//
//  YJLeaksViewController.m
//  YJLeaks
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJLeaksViewController.h"

@interface YJLeaksViewController ()

@property (nonatomic, strong) NSTimer *timer; ///<

@end

@implementation YJLeaksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:true];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (!self.navigationController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)test {
    NSLog(@"%@", self);
}

@end
