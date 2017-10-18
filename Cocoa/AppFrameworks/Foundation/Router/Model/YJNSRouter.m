//
//  YJNSRouter.m
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSRouter.h"

@implementation YJNSRouter

- (instancetype)initWithSourceRouter:(YJNSRouter *)sourceRouter sourceOptions:(NSDictionary<YJNSRouterOptionsKey,id> *)sourceOptions delegate:(id<YJNSRouterDelegate>)delegate routerNode:(YJNSRouterNode *)routerNode {
    self = [super init];
    if (self) {
        self.sourceRouter = sourceRouter;
        self.sourceOptions = sourceOptions;
        self.delegate = delegate;
        self.routerNode = routerNode;
    }
    return self;
}

@end
