//
//  YJUIPushPopVCTransitioning.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUIViewControllerAnimatedTransitioning.h"

NS_ASSUME_NONNULL_BEGIN

/** UINavigationController Push Pop 转场动画*/
@interface YJUIPushPopVCTransitioning : NSObject <UINavigationControllerDelegate>

@property (nonatomic, strong) YJUIViewControllerAnimatedTransitioning *pushAT; ///< push 动画

@property (nonatomic, strong) YJUIViewControllerAnimatedTransitioning *popAT; ///< pop 动画
@property (nonatomic, weak) UIViewController *popVC; ///< pop 的视图
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *popGesture; ///< pop 的手势

@end

NS_ASSUME_NONNULL_END
