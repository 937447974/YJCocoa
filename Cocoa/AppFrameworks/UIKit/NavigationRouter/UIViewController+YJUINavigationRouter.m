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
#import "YJSwizzling.h"

@implementation UIViewController (YJUINavigationRouter)

+ (void)load {
    [UIViewController swizzlingSEL:@selector(viewDidDisappear:) withSEL:@selector(router_viewDidDisappear:)];
}

- (void)router_viewDidDisappear:(BOOL)animated {
    [self router_viewDidDisappear:animated];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isEqual:self]) return;
    }
    [YJNSURLRouterS offlineNode:self];
}

#pragma mark - YJNSURLRouterProtocol
+ (instancetype)newWithRouterURL:(YJNSRouterURL)url {
    UIViewController *vc = self.new;
    vc.view.backgroundColor = UIColor.whiteColor;
    return vc;
}

- (void)openRouterCompletionHandler:(dispatch_block_t)completion {
    UIViewController *vc = UIApplication.sharedApplication.keyWindow.rootViewController;
    UINavigationController *nc = [vc isKindOfClass:[UINavigationController class]] ? (UINavigationController *)vc : vc.navigationController;
    [nc pushViewController:self animated:YES];
}

@end
