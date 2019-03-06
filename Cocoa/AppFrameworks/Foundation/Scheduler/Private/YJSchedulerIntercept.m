//
//  YJSchedulerIntercept.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/1/3.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#import "YJSchedulerIntercept.h"

@implementation YJSchedulerIntercept

- (instancetype)initWithInterceptor:(id)interceptor canHandler:(YJSInterceptCanHandler)canHandler completionHandler:(YJSInterceptHandler)handler {
    self = [super init];
    if (self) {
        self.interceptor = interceptor;
        self.canHandler = canHandler;
        self.completionHandler = handler;
    }
    return self;
}

@end
