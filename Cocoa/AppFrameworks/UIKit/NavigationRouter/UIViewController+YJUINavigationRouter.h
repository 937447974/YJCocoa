//
//  UIViewController+YJUINavigationRouter.h
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+YJNSRouter.h"

/** UIViewController路由导航扩展*/
@interface UIViewController (YJUINavigationRouter)

/**
 *  @abstract 移除当前 NavigationController 中的某个 UIViewController
 *
 *  @param vc 被移除的 UIViewController
 */
- (void)removeNavigationViewController:(UIViewController *)vc;

@end
