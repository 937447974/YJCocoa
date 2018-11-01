//
//  YJUIViewControllerAnimatedTransitioning.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+YJUIViewGeometry.h"
#import "YJNSSingleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJUIViewControllerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) NSTimeInterval transitionDuration ; ///< 动画时间，默认0.5

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext fromeView:(UIView *)fromView toView:(UIView *)toView completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
