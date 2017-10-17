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

@implementation UIViewController (YJUINavigationRouter)

- (void)removeNavigationViewController:(UIViewController *)vc {
    NSMutableArray *viewControllers = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *item in viewControllers) {
        if ([item isEqual:viewControllers]) {
            [viewControllers removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = viewControllers;
}

- (BOOL)openCurrentRouter {
    if ([self.router.sourceRouter.delegate isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)self.router.sourceRouter.delegate;
        if (vc.navigationController) {
            UIViewController *targetVC = self;
            if ([vc isEqual:targetVC]) {
                targetVC = 
            }      targetController = [[routerNode.routerClass alloc] initWithRouterURL:routerURL];
            if (![routerNode.scope isEqualToString:YJNSRouterNodeScopePrototype]) {
                [routeManager setObject:targetController forRouterNode:routerNode];
            }
        }
        // 加载数据
        YJNSRouter *targetRouter = [[YJNSRouter alloc] init];
        targetRouter.sourceRouter = self.router;
        targetRouter.sourceOptions = options;
        targetRouter.delegate = targetController;
        targetRouter.routerNodeL = routerNode;
        // 绑定
        targetController.router = targetRouter;
            [vc.navigationController pushViewController:self animated:YES];
            return YES;
        }
    }
    return [super openCurrentRouter];
}



- (void)viewDidDisappear:(BOOL)animated {
    self.navigationController.viewControllers
}

@end
