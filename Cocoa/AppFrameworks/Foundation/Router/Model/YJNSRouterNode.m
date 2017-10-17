//
//  YJNSRouterNode.m
//  YJUINavigationRouter
//
//  Created by didi on 2017/10/17.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJNSRouterNode.h"

YJNSRouterNodeScope const YJNSRouterNodeScopeSingleton = @"singleton";
YJNSRouterNodeScope const YJNSRouterNodeScopePrototype = @"prototype";

@implementation YJNSRouterNode

+ (YJNSRouterNode *)nodeWithRouterClass:(Class)routerClass scope:(YJNSRouterNodeScope)scope routerURL:(YJNSRouterURL)routerURL {
    YJNSRouterNode *node = [[YJNSRouterNode alloc] init];
    if (node) {
        node -> _routerClass = routerClass;
        node -> _scope = scope ?: YJNSRouterNodeScopePrototype;;
        node -> _routerURL = routerURL;
    }
    return node;
}

@end
