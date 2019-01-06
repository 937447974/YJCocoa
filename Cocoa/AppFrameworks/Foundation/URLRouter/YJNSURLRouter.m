//
//  YJNSURLRouter.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/10/18.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSURLRouter.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "YJScheduler.h"
#import "YJNSFoundationOther.h"
#import "YJNSHttp.h"
#import "YJDispatch.h"
#import "YJSystemOther.h"
#import "YJNSRouterUnregistered.h"
#import "YJNSLog.h"

@interface YJNSURLRouter () <YJSchedulerProtocol>

@property (nonatomic, strong) NSMutableDictionary<NSString *, YJNSRouterRegister *> *registerDict;
@property (nonatomic, strong) NSCache<NSString *, id> *nodeCache;

@end

@implementation YJNSURLRouter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.registerDict = NSMutableDictionary.dictionary;
        self.nodeCache = NSCache.new;
    }
    return self;
}

#pragma mark - Router
- (void)registerRouter:(YJNSRouterRegister *)rRegister {
    YJLogVerbose(@"URLRouter 注册%@", rRegister.url);
    @weakSelf
    [YJSchedulerS subscribeTopic:[self topicWithURL:rRegister.url] subscriber:self onQueue:YJSchedulerQueueMain completionHandler:^(id data, YJSPublishHandler publishHandler) {
        @strongSelf
        [self openRouterRegister:rRegister options:data completionHandler:publishHandler];
    }];
}

- (void)interceptUnregisteredCanOpen:(YJRUnregisteredCanOpen)canOpen openHandler:(YJROpenHandler)openHandler {
    @weakSelf
    [YJSchedulerS interceptWithInterceptor:self canHandler:^BOOL(NSString *topic) {
        @strongSelfReturn(NO)
        return canOpen([self urlWithTopic:topic]);
    } completionHandler:^BOOL(NSString *topic, id data, YJSPublishHandler publishHandler) {
        @strongSelfReturn(NO)
        NSString *url = [self urlWithTopic:topic];
        if (canOpen(url)) {
            YJLogVerbose(@"URLRouter 拦截%@", topic);
            openHandler(url, data, publishHandler);
            return YES;
        }
        return NO;
    }];
}


- (BOOL)canOpenURL:(NSString *)url {
    url = [self urlPrefixWithURL:url];
    return [YJSchedulerS canPublishTopic:[self topicWithURL:url]];
}

- (void)openURL:(NSString *)url options:(NSDictionary *)options completionHandler:(YJRCompletionHandler)completionHandler {
    YJLogVerbose(@"URLRouter 打开%@，options:%@", url, options);
    NSString *topic = [self topicWithURL:[self urlPrefixWithURL:url]];
    NSMutableDictionary *mOptions = NSMutableDictionary.dictionary;
    NSRange range = [url rangeOfString:@"?"];
    if (range.location != NSNotFound) [mOptions addEntriesFromDictionary:[YJNSHttpAnalysis analysisParamsDecode:url]];
    if (options.count) [mOptions addEntriesFromDictionary:options];
    [YJSchedulerS publishTopic:topic data:mOptions serial:YES completionHandler:completionHandler];
}

#pragma mark - Private
- (NSString *)topicWithURL:(NSString *)url {
    // scheme:[//[user:password@]host[:port]][/]path[?query][#fragment]
    return [NSString stringWithFormat:@"url:%@", url];
}

- (NSString *)urlWithTopic:(NSString *)topic {
    return [topic substringFromIndex:4];
}

- (NSString *)urlPrefixWithURL:(NSString *)url {
    NSRange range = [url rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        url = [url substringToIndex:range.location];
    }
    return url;
}

- (void)openRouterRegister:(YJNSRouterRegister *)rRegister options:(NSDictionary *)options completionHandler:(YJRCompletionHandler)completionHandler {
    if (rRegister.handler) {
        rRegister.handler(rRegister.url, options, completionHandler);
    } else {
        id<YJNSURLRouterProtocol> node = [self buildNodeWithRouterRegister:rRegister];
        if ([node respondsToSelector:@selector(routerReloadDataWithOptions:completionHandler:)]) {
            [node routerReloadDataWithOptions:options completionHandler:completionHandler];
        }
        if ([node respondsToSelector:@selector(routerOpen)]) {
            [node routerOpen];
        }
    }
}

- (id<YJNSURLRouterProtocol>)buildNodeWithRouterRegister:(YJNSRouterRegister *)rRegister {
    id<YJNSURLRouterProtocol> node;
    if (rRegister.cache) node = [self getCacheNodeWithRouterRegister:rRegister];
    if (node) return node;
    if ([rRegister.cls respondsToSelector:@selector(routerWithURL:)]) {
        node = [rRegister.cls routerWithURL:rRegister.url];
    } else {
        node = rRegister.cls.new;
    }
    if (rRegister.cache) [self.nodeCache setObject:node forKey:rRegister.url];
    return node;
}

- (id<YJNSURLRouterProtocol>)getCacheNodeWithRouterRegister:(YJNSRouterRegister *)rRegister {
    id<YJNSURLRouterProtocol> cacheNode = [self.nodeCache objectForKey:rRegister.url];
    if ([cacheNode isKindOfClass:UIViewController.class]) {
        UINavigationController *nc = ((UIViewController *)cacheNode).navigationController;
        for (UIViewController *vc in nc.viewControllers) {
            if ([cacheNode isEqual:vc]) return nil;
        }
    }
    return cacheNode;
}

#pragma mark - YJSchedulerProtocol
+ (void)schedulerLoad {
    unsigned int classCount;
    Class *classes = objc_copyClassList(&classCount);
    SEL sel = @selector(routerLoad);
    for (int i = 0; i < classCount; i++) {
        Class cls = classes[i];
        if (class_getClassMethod(cls, sel)) {
            @warningPerformSelector([cls performSelector:sel])
        }
    }
    free(classes);
}

@end
