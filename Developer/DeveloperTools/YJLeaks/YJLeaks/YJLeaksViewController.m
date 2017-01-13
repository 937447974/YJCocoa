//
//  YJLeaksViewController.m
//  YJLeaks
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJLeaksViewController.h"
#import "YJLeaksView.h"

@interface YJLeaksViewController ()

@property (nonatomic, strong) NSTimer *timer; ///<
@property (nonatomic, strong) YJLeaksView *leaksView; ///<

@end

@implementation YJLeaksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
// [self testViewController];
//    [self testView];
    [self testProperty];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (!self.navigationController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIViewController
- (void)testViewController {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:true];
}

- (void)test {
    NSLog(@"%@", self);
}

#pragma mark - UIView
- (void)testView {
    YJLeaksView *view = [[YJLeaksView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    view.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:view selector:@selector(test) userInfo:nil repeats:true];
}

#pragma mark - Property
- (void)testProperty {
    self.leaksView = [[YJLeaksView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.leaksView.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.leaksView selector:@selector(test) userInfo:nil repeats:true];
}

@end
