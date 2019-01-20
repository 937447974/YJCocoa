//
//  YJSchedulerSubscribe.m
//  Pods
//
//  Created by 阳君 on 2018/12/29.
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
