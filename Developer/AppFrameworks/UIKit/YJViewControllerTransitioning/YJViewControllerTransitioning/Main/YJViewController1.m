//
//  YJViewController1.m
//  YJViewControllerTransitioning
//
//  Created by YJCocoa on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "YJViewController1.h"
#import "YJViewController2.h"
#import "YJUIViewControllerTransitioning.h"

@interface YJViewController1 ()

@property (nonatomic, strong) YJUIPresentDismissVCTransitioning *pdVCTransitioning;
@property (nonatomic, strong) YJUIPushPopVCTransitioning *ppVCTransitioning;

@end

@implementation YJViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.pdVCTransitioning = YJUIPresentDismissVCTransitioning.new;
    self.ppVCTransitioning = YJUIPushPopVCTransitioning.new;
//        [self testPresentDismiss];
        [self testPushPop];
}

- (void)testPresentDismiss {
    YJViewController2 *vc = [[YJViewController2 alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    nc.transitioningDelegate = self.pdVCTransitioning;
    self.pdVCTransitioning.dismissVC = nc;
//    self.pdVCTransitioning.presentAT = YJUIPresentVCAnimatedTransitioningS;
//    self.pdVCTransitioning.dismissAT = YJUIDismissVCAnimatedTransitioningS;
    
//    self.pdVCTransitioning.presentAT = YJUIPresentVCAnimatedTransitioningS;
//    self.pdVCTransitioning.dismissAT = YJUIPopVCAnimatedTransitioningS;
    
    self.pdVCTransitioning.presentAT = YJUIPushVCAnimatedTransitioningS;
    self.pdVCTransitioning.dismissAT = YJUIPopVCAnimatedTransitioningS;
    
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)testPushPop {
    YJViewController2 *vc = [[YJViewController2 alloc] init];
    self.navigationController.delegate = self.ppVCTransitioning;
    self.ppVCTransitioning.pushAT = YJUIPushVCAnimatedTransitioningS;
    self.ppVCTransitioning.popAT = YJUIPopVCAnimatedTransitioningS;
    
//    self.ppVCTransitioning.pushAT = YJUIPushVCAnimatedTransitioningS;
//    self.ppVCTransitioning.popAT = YJUIDismissVCAnimatedTransitioningS;
    
    self.ppVCTransitioning.popVC = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
