//
//  YJUIPresentDismissVCTransitioning.h
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

/** UIViewController Present Dismiss 转场动画*/
@interface YJUIPresentDismissVCTransitioning : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) YJUIViewControllerAnimatedTransitioning *presentAT; ///< present 动画

@property (nonatomic, strong) YJUIViewControllerAnimatedTransitioning *dismissAT; ///< dismiss 动画
@property (nonatomic, weak) UIViewController *dismissVC; ///< dismiss 的VC

@end

NS_ASSUME_NONNULL_END
