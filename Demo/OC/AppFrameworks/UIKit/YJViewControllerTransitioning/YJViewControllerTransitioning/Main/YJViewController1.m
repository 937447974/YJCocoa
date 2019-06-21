//
//  YJViewController1.m
//  YJViewControllerTransitioning
//
//  Created by YJCocoa on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "YJViewController1.h"
#import "YJViewController2.h"
#import <YJCocoa/YJCocoa-Swift.h>

@interface YJViewController1 ()

@property (nonatomic, strong) YJUIViewControllerTransitioning *vcTransitioning;

@end

@implementation YJViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1";
    self.vcTransitioning = YJUIViewControllerTransitioning.new;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        [self testPresentDismiss];
//        [self testPushPop];
}

- (void)testPresentDismiss {
    YJViewController2 *vc = [[YJViewController2 alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    YJUIViewControllerAnimatedTransitioning *pushAT = YJUIPresentVCAnimatedTransitioning.new;
    YJUIViewControllerAnimatedTransitioning *popAT = YJUIDismissVCAnimatedTransitioning.new;
    [self.vcTransitioning setPushAT:pushAT popAT:popAT popVC:nc];
    nc.transitioningDelegate = self.vcTransitioning;
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)testPushPop {
    YJViewController2 *vc = [[YJViewController2 alloc] init];
    YJUIViewControllerAnimatedTransitioning *pushAT = YJUIPushVCAnimatedTransitioning.new;
    YJUIViewControllerAnimatedTransitioning *popAT = YJUIPopVCAnimatedTransitioning.new;
    [self.vcTransitioning setPushAT:pushAT popAT:popAT popVC:vc];
    self.navigationController.delegate = self.vcTransitioning;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
