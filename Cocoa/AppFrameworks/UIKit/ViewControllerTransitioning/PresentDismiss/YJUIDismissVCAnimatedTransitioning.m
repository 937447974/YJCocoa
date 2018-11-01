//
//  YJUIDismissVCAnimatedTransitioning.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "YJUIDismissVCAnimatedTransitioning.h"

@implementation YJUIDismissVCAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromeView:(UIView *)fromView toView:(UIView *)toView completion:(nonnull void (^)(BOOL))completion {
    [transitionContext.containerView insertSubview:toView belowSubview:fromView];
    [UIView animateWithDuration:self.transitionDuration animations:^{
        fromView.topFrame = UIScreen.mainScreen.bounds.size.height;
    } completion:completion];
}

@end
