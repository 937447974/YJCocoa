//
//  YJUIPresentVCAnimatedTransitioning.h
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

/** Present 动画单例*/
#define YJUIPresentVCAnimatedTransitioningS YJNSSingletonS(YJUIPresentVCAnimatedTransitioning, nil)

/** Present 动画*/
@interface YJUIPresentVCAnimatedTransitioning : YJUIViewControllerAnimatedTransitioning

@end

NS_ASSUME_NONNULL_END
