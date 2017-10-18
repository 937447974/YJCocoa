//
//  YJNSRouterNode.m
//  YJUINavigationRouter
//
//  Created by didi on 2017/10/17.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJNSRouterNode.h"

YJNSRouterScope const YJNSRouterScopeSingleton = @"singleton";
YJNSRouterScope const YJNSRouterScopePrototype = @"prototype";
YJNSRouterScope const YJNSRouterScopeMemoryWarning = @"memoryWarning";

@implementation YJNSRouterNode

+ (YJNSRouterNode *)nodeWithRouterClass:(Class)routerClass scope:(YJNSRouterScope)scope routerURL:(YJNSRouterURL)routerURL {
    YJNSRouterNode *node = [[YJNSRouterNode alloc] init];
    if (node) {
        node -> _routerClass = routerClass;
        node -> _scope = scope ?: YJNSRouterScopePrototype;;
        node -> _routerURL = routerURL;
    }
    return node;
}

@end
