//
//  YJUIViewControllerAnimatedTransitioning.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "YJUIViewControllerAnimatedTransitioning.h"

@implementation YJUIViewControllerAnimatedTransitioning

- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitionDuration = 0.5;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [self animateTransition:transitionContext fromeView:fromView toView:toView completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromeView:(UIView *)fromView toView:(UIView *)toView completion:(nonnull void (^)(BOOL))completion {}

@end
