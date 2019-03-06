//
//  YJScheduler.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/12/29.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#import "YJScheduler.h"
#import "NSNotificationCenter+YJ.h"
#import "YJNSFoundationOther.h"
#import "YJNSLog.h"
#import "YJSystemOther.h"
#import "YJDispatch.h"
#import "YJSchedulerSubscribe.h"
#import "YJSchedulerIntercept.h"

@interface YJScheduler ()

@property (nonatomic) BOOL initSubInt;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray *> *subDict;
@property (nonatomic, strong) NSMutableArray<YJSchedulerIntercept *> *intArray;

@property (nonatomic, strong) YJDispatchQueue *workQueue;
@property (nonatomic, strong) YJDispatchQueue *serialQueue;
@property (nonatomic, strong) YJDispatchQueue *concurrentQueue;

@end

@implementation YJScheduler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.subDict = NSMutableDictionary.dictionary;
        self.intArray = NSMutableArray.array;
        [self notificationInjection];
    }
    return self;
}

- (void)notificationInjection {
    @weakSelf
    void (^ block)(NSNotification *) = ^(NSNotification *note) {
        @strongSelf
        [self.workQueue addAsync:YES executionBlock:^{
            @strongSelf
            for (NSMutableArray *subArray in self.subDict.allValues) {
                for (NSInteger i = subArray.count - 1; i >= 0; i--) {
                    YJSchedulerSubscribe *item = subArray[i];
                    if (!item.subscriber) [subArray removeObjectAtIndex:i];
                }
            }
        }];
    };
    [NSNotificationCenter.defaultCenter addObserver:self name:UIApplicationDidReceiveMemoryWarningNotification usingBlock:block];
    [NSNotificationCenter.defaultCenter addObserver:self name:UIApplicationDidEnterBackgroundNotification usingBlock:block];
}

- (void)initLoadScheduler {
    if (self.initSubInt) return;
    self.initSubInt = YES;
    [self.workQueue addAsync:NO executionBlock:^{
        YJCI_BLOCK_EXECUTE(YJSchedulerLoad)
    }];
}

- (NSMutableArray *)subscribeArrayWithTopic:(NSString *)topic {
    NSMutableArray *array = [self.subDict objectForKey:topic];
    if (!array) {
        array = NSMutableArray.array;
        [self.subDict setObject:array forKey:topic];
    }
    return array;
}

#pragma mark - One To More
#pragma mark subscribe
- (void)subscribeTopic:(NSString *)topic subscriber:(id)subscriber onQueue:(YJSchedulerQueue)queue completionHandler:(YJSSubscribeHandler)handler {
    YJLogVerbose(@"[Scheduler] 订阅%@", topic);
    subscriber = subscriber ?: self.class;
    @weakSelf
    [self.workQueue addAsync:YES executionBlock:^{
        @strongSelf
        NSMutableArray *subArray = [self subscribeArrayWithTopic:topic];
        for (YJSchedulerSubscribe *item in subArray) {
            if ([item.topic isEqualToString:topic] && [item.subscriber isEqual:subscriber])
            return;
        }
        [subArray addObject:[[YJSchedulerSubscribe alloc] initWithTopic:topic subscriber:subscriber queue:queue completionHandler:handler]];
    }];
}

- (void)removeSubscribeTopic:(NSString *)topic subscriber:(id)subscriber {
    if (!subscriber) return;
    @weakSelf
    [self.workQueue addAsync:YES executionBlock:^{
        @strongSelf
        if (topic.length) {
            [self removeSubscribeArray:[self subscribeArrayWithTopic:topic] subscriber:subscriber];
        } else {
            for (NSMutableArray *subArray in self.subDict.allValues) {
                [self removeSubscribeArray:subArray subscriber:subscriber];
            }
        }
    }];
}

- (void)removeSubscribeArray:(NSMutableArray *)subArray subscriber:(id)subscriber {
    for (NSInteger i = subArray.count - 1; i >= 0; i--) {
        YJSchedulerSubscribe *item = subArray[i];
        if (item.subscriber) {
            if (item.subscriber == subscriber) {
                [subArray removeObjectAtIndex:i];
                return;
            }
        } else {
            [subArray removeObjectAtIndex:i];
        }
    }
}

#pragma mark intercept
- (void)interceptWithInterceptor:(id)interceptor canHandler:(YJSInterceptCanHandler)canHandler completionHandler:(YJSInterceptHandler)handler {
    @weakSelf
    [self.workQueue addAsync:NO executionBlock:^{
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
    [self initLoadScheduler];
    for (YJSchedulerIntercept *item in self.intArray.copy) {
        if (item.interceptor && item.canHandler(topic)) return YES;
    }
    NSArray *subArray = [self subscribeArrayWithTopic:topic].copy;
    for (YJSchedulerSubscribe *item in subArray) {
        if (item.subscriber) return YES;
    }
    return NO;
}

- (void)publishTopic:(NSString *)topic data:(id)data serial:(BOOL)serial completionHandler:(YJSPublishHandler)handler {
    [self initLoadScheduler];
    YJLogVerbose(@"[Scheduler] 发布%@, data:%@", topic, data);
    @weakSelf
    [self.workQueue addAsync:YES executionBlock:^{
        @strongSelf
        for (YJSchedulerIntercept *item in self.intArray) {
            if (item.interceptor && item.canHandler(topic)) {
                if (item.completionHandler(topic, data, handler)) return;
            }
        }
        NSArray *subArray = [self subscribeArrayWithTopic:topic].copy;
        for (YJSchedulerSubscribe *item in subArray) {
            if (item.subscriber) {
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
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    YJLogError(@"[Scheduler] 调用未知方法：%@", NSStringFromSelector(selector));
    return [YJScheduler instanceMethodSignatureForSelector:@selector(unrecognizedSelector)];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self];
}

- (id)unrecognizedSelector {
    return nil;
}

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
        dispatch_queue_t queue = dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT);
        _concurrentQueue = [[YJDispatchQueue alloc] initWithLabel:label queue:queue maxConcurrent:6];
    }
    return _concurrentQueue;
}

@end
