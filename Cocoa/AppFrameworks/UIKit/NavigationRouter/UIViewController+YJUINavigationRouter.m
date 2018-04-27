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
    UIViewController *svc = [sourceRouter.delegate isKindOfClass:[UIViewController class]] ? (UIViewController *)sourceRouter.delegate : UIApplication.sharedApplication.keyWindow.rootViewController;
    UINavigationController *snc = [svc isKindOfClass:[UINavigationController class]] ? (UINavigationController *)svc : svc.navigationController;
    if (snc) {
        UIViewController *targetVC = self;
        YJNSRouterNode *routerNode = self.router.routerNode;
        if (![routerNode.scope isEqualToString:YJNSRouterScopePrototype]) {
            // navigationController 只能存在一份VC，否则程序崩溃
            BOOL include = NO;
            for (UIViewController *childVC in snc.viewControllers) {
                if ([childVC isEqual:targetVC]) {
                    include = YES;
                    break;
                }
            }
            if (include) {
                targetVC = [[routerNode.routerClass alloc] initWithRouterURL:routerNode.routerURL];
            }
        }
        [snc pushViewController:targetVC animated:YES];
        completion(targetVC);
        return YES;
    }
    return [super openCurrentRouterFromSourceRouter:sourceRouter completion:completion];
}

@end
