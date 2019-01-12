//
//  YJScheduler.m
//  Pods-YJScheduler
//
//  Created by CISDI on 2018/12/29.
//

#import "YJScheduler.h"
#import "YJNSFoundationOther.h"
#import "YJNSLog.h"
#import "YJSystemOther.h"
#import "YJDispatch.h"
#import "YJSchedulerSubscribe.h"
#import "YJSchedulerIntercept.h"

@interface YJScheduler ()

@property (nonatomic, strong) NSMutableArray<YJSchedulerSubscribe *> *subArray;
@property (nonatomic, strong) NSMutableArray<YJSchedulerIntercept *> *intArray;

@property (nonatomic, strong) YJDispatchQueue *workQueue;
@property (nonatomic, strong) YJDispatchQueue *serialQueue;
@property (nonatomic, strong) YJDispatchQueue *concurrentQueue;

@end

@implementation YJScheduler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.subArray = NSMutableArray.array;
        self.intArray = NSMutableArray.array;
        @weakSelf
        [self.workQueue addAsync:YES executionBlock:^{
            @strongSelf
            [self initLoadScheduler];
        }];
    }
    return self;
}

- (void)initLoadScheduler {
    SEL sel = @selector(schedulerLoad);
    NSArray *array = [NSObject allClassRespondsToSelector:sel];
    for (Class cls in array) {
        @warningPerformSelector([cls performSelector:sel])
    }
}

#pragma mark - One To More
#pragma mark subscribe
- (void)subscribeTopic:(NSString *)topic subscriber:(id)subscriber onQueue:(YJSchedulerQueue)queue completionHandler:(YJSSubscribeHandler)handler {
    YJLogVerbose(@"Scheduler 订阅%@", topic);
    @weakSelf
    [self.workQueue addAsync:YES executionBlock:^{
        @strongSelf
        if (self.subArray.count >= 100) {
            NSMutableArray *array = NSMutableArray.array;
            for (YJSchedulerSubscribe *item in self.subArray) {
                if (item) [array addObject:item];
            }
            self.subArray = array;
        }
        YJSchedulerSubscribe *item = [[YJSchedulerSubscribe alloc] initWithTopic:topic subscriber:subscriber?:self.class queue:queue completionHandler:handler];
        [self.subArray addObject:item];
    }];
}

#pragma mark intercept
- (void)interceptWithInterceptor:(id)interceptor canHandler:(YJSInterceptCanHandler)canHandler completionHandler:(YJSInterceptHandler)handler {
    @weakSelf
    [self.workQueue addAsync:YES executionBlock:^{
        @strongSelf
        if (self.intArray.count >= 100) {
            NSMutableArray *array = NSMutableArray.array;
            for (YJSchedulerIntercept *item in self.intArray) {
                if (item) [array addObject:item];
            }
            self.intArray = array;
        }
        YJSchedulerIntercept *item = [[YJSchedulerIntercept alloc] initWithInterceptor:interceptor?:self.class canHandler:canHandler completionHandler:handler];
        [self.intArray addObject:item];
    }];
}

#pragma mark publish
- (BOOL)canPublishTopic:(NSString *)topic {
    for (YJSchedulerIntercept *item in self.intArray.copy) {
        if (item.interceptor && item.canHandler(topic)) return YES;
    }
    for (YJSchedulerSubscribe *item in self.subArray.copy) {
        if (item.subscriber && [topic isEqualToString:item.topic]) return YES;
    }
    return NO;
}

- (void)publishTopic:(NSString *)topic data:(id)data serial:(BOOL)serial completionHandler:(YJSPublishHandler)handler {
    YJLogVerbose(@"Scheduler 发布%@, data:%@", topic, data);
    @weakSelf
    [self.workQueue addAsync:YES executionBlock:^{
        @strongSelf
        for (YJSchedulerIntercept *item in self.intArray) {
            if (item.interceptor && item.canHandler(topic)) {
                if (item.completionHandler(topic, data, handler)) return;
            }
        }
        for (YJSchedulerSubscribe *item in self.subArray) {
            if (item.subscriber && [topic isEqualToString:item.topic]) {
                dispatch_block_t block = ^{
                    item.completionHandler(data, handler);
                };
                if (item.queue == YJSchedulerQueueMain) {
                    dispatch_async_main(block);
                } else {
                    YJDispatchQueue *queue = serial ? self.serialQueue : self.concurrentQueue;
                    [queue addAsync:YES executionBlock:block];
                }
            }
        }
    }];
}

#pragma mark - One To one

#pragma mark - Getter
- (YJDispatchQueue *)workQueue {
    if (!_workQueue) {
        const char *label = "com.yjcocoa.scheduler.work";
        dispatch_queue_t queue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
        _workQueue = [[YJDispatchQueue alloc] initWithLabel:label queue:queue maxConcurrent:1];
    }
    return _workQueue;
}

- (YJDispatchQueue *)serialQueue {
    if (!_serialQueue) {
        const char *label = "com.yjcocoa.scheduler.serial";
        dispatch_queue_t queue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
        _serialQueue = [[YJDispatchQueue alloc] initWithLabel:label queue:queue maxConcurrent:1];
    }
    return _serialQueue;
}

- (YJDispatchQueue *)concurrentQueue {
    if (!_concurrentQueue) {
        const char *label = "com.yjcocoa.scheduler.concurrent";
        dispatch_queue_t queue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
        _concurrentQueue = [[YJDispatchQueue alloc] initWithLabel:label queue:queue maxConcurrent:6];
    }
    return _concurrentQueue;
}

@end
