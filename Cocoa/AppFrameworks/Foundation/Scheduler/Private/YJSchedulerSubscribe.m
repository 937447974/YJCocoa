//
//  YJSchedulerSubscribe.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/12/29.
//  Copyright © 2018年 YJCocoa. All rights reserved.
//

#import "YJSchedulerSubscribe.h"

@implementation YJSchedulerSubscribe

- (instancetype)initWithTopic:(NSString *)topic subscriber:(id)subscriber queue:(YJSchedulerQueue)queue completionHandler:(YJSSubscribeHandler)completionHandler {
    self = [self init];
    if (self) {
        self.topic = topic;
        self.subscriber = subscriber;
        self.queue = queue;
        self.completionHandler = completionHandler;
    }
    return self;
}

@end
