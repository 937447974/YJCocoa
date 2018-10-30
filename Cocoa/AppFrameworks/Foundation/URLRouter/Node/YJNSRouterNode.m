//
//  YJNSRouterNode.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/10/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSRouterNode.h"

@implementation YJNSRouterNode

- (instancetype)initWithSource:(id)source config:(YJNSRouterNodeConfig *)config {
    self = [super init];
    if (self) {
        self.source = source;
        self.config = config;
    }
    return self;
}

@end
