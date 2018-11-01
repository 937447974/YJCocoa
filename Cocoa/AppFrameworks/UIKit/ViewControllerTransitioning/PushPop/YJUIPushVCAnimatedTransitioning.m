//
//  YJUIPushVCAnimatedTransitioning.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "YJUIPushVCAnimatedTransitioning.h"

@implementation YJUIPushVCAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromeView:(UIView *)fromView toView:(UIView *)toView completion:(void (^)(BOOL))completion {
    [transitionContext.containerView addSubview:toView];
    toView.leadingFrame = toView.widthFrame;
    [UIView animateWithDuration:self.transitionDuration animations:^{
        toView.leadingFrame = 0;
    } completion:completion];
}

@end
