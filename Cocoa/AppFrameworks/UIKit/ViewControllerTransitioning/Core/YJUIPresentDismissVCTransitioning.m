//
//  YJUIPresentDismissVCTransitioning.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "YJUIPresentDismissVCTransitioning.h"

@interface YJUIPresentDismissVCTransitioning ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *dismissIT;

@end

@implementation YJUIPresentDismissVCTransitioning

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)pan {
    CGFloat process = [pan translationInView:self.dismissVC.view].x / self.dismissVC.view.widthFrame;
    process = MIN(1.0, MAX(0.0, process));
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.dismissIT = UIPercentDrivenInteractiveTransition.new;
            [self.dismissVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            [self.dismissIT updateInteractiveTransition:process];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (process > 0.5) [self.dismissIT finishInteractiveTransition];
            else [self.dismissIT cancelInteractiveTransition];
            self.dismissIT = nil;
            break;
        default:
            break;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentAT;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAT;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.dismissIT;
}

#pragma mark - Setter & Getter
- (void)setDismissVC:(UIViewController *)dismissVC {
    if ([_dismissVC isEqual:dismissVC]) return;
    _dismissVC = dismissVC;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] init];
    [panGesture addTarget:self action:@selector(panGestureRecognizerAction:)];
    [_dismissVC.view addGestureRecognizer:panGesture];
}

@end
