//
//  YJUIPopVCAnimatedTransitioning.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "YJUIPopVCAnimatedTransitioning.h"

@implementation YJUIPopVCAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromeView:(UIView *)fromView toView:(UIView *)toView completion:(void (^)(BOOL))completion {
    [transitionContext.containerView insertSubview:toView belowSubview:fromView];
    fromView.leadingFrame = 0;
    [UIView animateWithDuration:self.transitionDuration animations:^{
        fromView.leadingFrame = fromView.widthFrame;
    } completion:completion];
}

@end
