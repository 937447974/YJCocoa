//
//  YJNSRouteManager.m
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSRouteManager.h"

@interface YJNSRouteManager ()

@property (nonatomic, strong) NSMutableDictionary<YJNSRouterURL, YJNSRouterNode *> *routerPool; ///< 节点池
@property (nonatomic, strong) NSMutableDictionary<YJNSRouterScope, NSMutableDictionary<YJNSRouterURL, id> *> *routerCache; ///< 缓存池

@end

@implementation YJNSRouteManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.routerPool = [NSMutableDictionary dictionary];
        self.routerCache = [NSMutableDictionary dictionary];
        self.routerNodeBlock = ^YJNSRouterNode *(YJNSRouterURL routerURL) {
            return nil;
        };
    }
    return self;
}

#pragma mark - routerPool
- (void)registerRouterNode:(YJNSRouterNode *)routerNode {
    [self.routerPool setObject:routerNode forKey:routerNode.routerURL];
}

- (YJNSRouterNode *)routerNodeForURL:(YJNSRouterURL)routerURL {
    YJNSRouterNode *node = [self.routerPool objectForKey:routerURL];
    node = node? : self.routerNodeBlock(routerURL);
    NSAssert(node, @"路由节点 %@ 不存在", routerURL);
    return node;
}

#pragma mark - cache
- (void)setObject:(id)anObject forRouterNode:(YJNSRouterNode *)routerNode {
    if ([routerNode.scope isEqualToString:YJNSRouterScopePrototype]) {
        return;
    }
    NSMutableDictionary *dict = [self.routerCache objectForKey:routerNode.scope];
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
        [self.routerCache setObject:dict forKey:routerNode.scope];
    }
    [dict setObject:anObject forKey:routerNode.routerURL];
}

- (id)objectForRouterNode:(YJNSRouterNode *)routerNode {
    return [[self.routerCache objectForKey:routerNode.scope] objectForKey:routerNode.routerURL];
}

- (void)removeObjectForRouterNode:(YJNSRouterNode *)routerNode {
    [[self.routerCache objectForKey:routerNode.scope] removeObjectForKey:routerNode.routerURL];
}

- (void)removeObjectsForScope:(YJNSRouterScope)scope {
    [self.routerCache removeObjectForKey:scope];
}

@end
