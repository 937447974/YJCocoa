//
//  YJUIPushPopVCTransitioning.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "YJUIPushPopVCTransitioning.h"

@interface YJUIPushPopVCTransitioning ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *popIT;
@property (nonatomic, strong, readwrite) UIPanGestureRecognizer *popGesture;

@end

@implementation YJUIPushPopVCTransitioning

- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)pan {
    CGFloat process = [pan translationInView:self.popVC.view].x / self.popVC.view.widthFrame;
    process = MIN(1.0, MAX(0.0, process));
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.popIT = UIPercentDrivenInteractiveTransition.new;
            [self.popVC.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            [self.popIT updateInteractiveTransition:process];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            if (process > 0.5) [self.popIT finishInteractiveTransition];
            else [self.popIT cancelInteractiveTransition];
            self.popIT = nil;
            break;
        default:
            break;
    }
}

#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isEqual:self.popAT]) return self.popIT;
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    switch (operation) {
        case UINavigationControllerOperationPush: return self.pushAT;
        case UINavigationControllerOperationPop: return self.popAT;
        default: return nil;
    }
}

#pragma mark - Setter & Getter
- (void)setPopVC:(UIViewController *)popVC {
    if ([popVC isEqual:_popVC]) return;
    _popVC = popVC;
    [_popVC.view addGestureRecognizer:self.popGesture];
}

- (UIPanGestureRecognizer *)popGesture {
    if (!_popGesture) {
       _popGesture = [[UIPanGestureRecognizer alloc] init];
        [_popGesture addTarget:self action:@selector(panGestureRecognizerAction:)];
    }
    return _popGesture;
}

@end
