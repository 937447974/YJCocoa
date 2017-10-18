//
//  NSObject+YJNSRouter.m
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "NSObject+YJNSRouter.h"
#import <objc/runtime.h>
#import "YJNSHttp.h"

@implementation NSObject (YJNSRouter)

#pragma mark getter & setter
- (YJNSRouter *)router {
    YJNSRouter *router = objc_getAssociatedObject(self, "YJNSRouter");
    if (!router) {
        router = [[YJNSRouter alloc] init];
        [self setRouter:router];
        router.delegate = self;
        router.routerNode = [YJNSRouterNode nodeWithRouterClass:self.class scope:nil routerURL:@"root"];
    }
    return router;
}

- (void)setRouter:(YJNSRouter *)router {
    objc_setAssociatedObject(self, "YJNSRouter", router, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 当前页面操作
- (instancetype)initWithRouterURL:(YJNSRouterURL)routerURL {
    return [self init];
}

- (BOOL)openCurrentRouterFromSourceRouter:(YJNSRouter *)sourceRouter completion:(void (^)(NSObject *))completion {
    return NO;
}

- (void)reloadRouterData {
}

#pragma mark - 和下个页面交互
- (BOOL)receiveTargetRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey,id> *)options sender:(YJNSRouter *)sender {
    return NO;
}

- (BOOL)openRouterURL:(YJNSRouterURL)routerURL {
    NSArray *array = [routerURL componentsSeparatedByString:@"?"];
    if (array.count == 1) {
        return [self openRouterURL:array.firstObject options:@{}];
    } else if (array.count == 2) {
        return [self openRouterURL:array.firstObject options:[YJNSHttpAnalysis analysisParamsDecode:array.lastObject]];
    }
    return NO;
}

- (BOOL)openRouterURL:(YJNSRouterURL)routerURL options:(NSDictionary<YJNSRouterOptionsKey,id> *)options {
    YJNSRouteManager *routeManager = YJNSRouteManagerS;
    YJNSRouterNode *routerNode = [routeManager routerNodeForURL:routerURL];
    NSAssert(routerNode, @"路由节点 %@ 不存在", routerURL);
    NSObject *targetController = [routeManager objectForRouterNode:routerNode];
    if (!targetController) {
        targetController = [[routerNode.routerClass alloc] initWithRouterURL:routerURL];
        [routeManager setObject:targetController forRouterNode:routerNode];
    }
    YJNSRouter *sourceRouter = self.router;
    void (^ completion)(NSObject *controller) = ^(NSObject *controller) {
        if (![controller isEqual:targetController]) {
            [routeManager setObject:controller forRouterNode:routerNode];
        }
        controller.router = [[YJNSRouter alloc] initWithSourceRouter:sourceRouter sourceOptions:options delegate:controller routerNode:routerNode];
        [controller reloadRouterData];        
    };
    return [targetController openCurrentRouterFromSourceRouter:sourceRouter completion:completion];
}

#pragma mark - 和上个页面交互
- (BOOL)sendSourceRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey,id> *)options {
    YJNSRouter *sourceRouter = self.router.sourceRouter;
    while (sourceRouter) {
        if ([sourceRouter.delegate receiveTargetRouter:fID options:options sender:self.router]) {
            return YES;
        }
        sourceRouter = sourceRouter.sourceRouter;
    }
    return NO;
}

@end
