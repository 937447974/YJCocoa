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

/** 转场动画基类*/
@interface YJUIViewControllerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) NSTimeInterval transitionDuration ; ///< 动画时间，默认0.5

/**
 *  @abstract 执行动画
 *  @discusstion 子类实现
 *
 *  @param transitionContext id <UIViewControllerContextTransitioning>
 *  @param fromView 当前 UIView
 *  @param toView 将要显示的 UIView
 *  @param completion 完成回调
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext fromeView:(UIView *)fromView toView:(UIView *)toView completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
