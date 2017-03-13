//
//  UIViewController+YJUINavigationRouter.m
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "UIViewController+YJUINavigationRouter.h"
#import "YJNSRouterPrivateHeader.h"

@implementation UIViewController (YJUINavigationRouter)

- (BOOL)openCurrentRouter {
    if ([self.router.sourceRouter.delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)self.router.sourceRouter.delegate;
        if (vc.navigationController) {
            [vc.navigationController pushViewController:self animated:YES];
            return YES;
        }
    }
    return [super openCurrentRouter];
}

@end
