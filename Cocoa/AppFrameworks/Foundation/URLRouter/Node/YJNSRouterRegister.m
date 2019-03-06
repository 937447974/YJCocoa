//
//  YJNSRouterRegister.m
//  YJUINavigationRouter
//
//  Created by 阳君 on 2017/10/17.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJNSRouterRegister.h"

@implementation YJNSRouterRegister

- (instancetype)initWithClass:(Class)cls url:(NSString *)url cache:(BOOL)cache {
    self = [super init];
    if (self) {
        self.url = url;
        self.cache = cache;
        self.cls = cls;
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)url handler:(YJROpenHandler)handler {
    self = [super init];
    if (self) {
        self.url = url;
        self.handler = handler;
    }
    return self;
}

@end
