//
//  YJNSRouterNodeConfig.m
//  YJUINavigationRouter
//
//  Created by 阳君 on 2017/10/17.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJNSRouterNodeConfig.h"

@implementation YJNSRouterNodeConfig

- (instancetype)initWithRouterURL:(YJNSRouterURL)url cache:(BOOL)cache cls:(Class)cls {
    self = [super init];
    if (self) {
        self.url = url;
        self.cache = cache;
        self.cls = cls;
    }
    return self;
}

- (instancetype)initWithRouterURL:(YJNSRouterURL)url handler:(YJNSRouterNodeConfigHandler)handler {
    self = [super init];
    if (self) {
        self.url = url;
        self.handler = handler;
    }
    return self;
}

@end
