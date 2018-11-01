//
//  YJUIPushVCAnimatedTransitioning.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/11/1.
//  Copyright © 2018 YJCocoa. All rights reserved.
//

#import "YJUIViewControllerAnimatedTransitioning.h"

NS_ASSUME_NONNULL_BEGIN

/** Push 动画单例*/
#define YJUIPushVCAnimatedTransitioningS YJNSSingletonS(YJUIPushVCAnimatedTransitioning, nil)

/** Push 动画*/
@interface YJUIPushVCAnimatedTransitioning : YJUIViewControllerAnimatedTransitioning

@end

NS_ASSUME_NONNULL_END
