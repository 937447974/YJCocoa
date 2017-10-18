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
#import <objc/runtime.h>

@implementation UIViewController (YJUINavigationRouter)

- (BOOL)openCurrentRouterFromSourceRouter:(YJNSRouter *)sourceRouter completion:(void (^)(NSObject *))completion {
    if ([sourceRouter.delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *sourceVC = (UIViewController *)sourceRouter.delegate;
        if (sourceVC.navigationController) {
            UIViewController *targetVC = self;
            YJNSRouterNode *routerNode = self.router.routerNode;
            if (![self.router.routerNode.scope isEqualToString:YJNSRouterScopePrototype]) {
                BOOL include = NO;
                for (UIViewController *childVC in sourceVC.navigationController.viewControllers) {
                    if ([childVC isEqual:targetVC]) {
                        include = YES;
                        break;
                    }
                }
                if (include) {
                    targetVC = [[routerNode.routerClass alloc] initWithRouterURL:routerNode.routerURL];
                }
            }
            [sourceVC.navigationController pushViewController:targetVC animated:YES];
            completion(targetVC);
            return YES;
        }
    }
    return [super openCurrentRouterFromSourceRouter:sourceRouter completion:completion];
}

@end
