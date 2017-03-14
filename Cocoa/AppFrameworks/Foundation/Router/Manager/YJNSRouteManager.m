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

@property (nonatomic, strong) NSMutableDictionary<YJNSRouterURL, Class> *routerPool; ///< 路由器池

@end

@implementation YJNSRouteManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.routerPool = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - routerPool
- (void)registerRouter:(Class)routerClass forURL:(YJNSRouterURL)routerURL {
    [self.routerPool setObject:routerClass forKey:routerURL];
}

- (Class)routerClassForURL:(YJNSRouterURL)routerURL {
    return [self.routerPool objectForKey:routerURL];
}

@end
