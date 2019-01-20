//
//  YJSchedulerIntercept.m
//  Pods-YJScheduler
//
//  Created by 阳君 on 2019/1/3.
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
