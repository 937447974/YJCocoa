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
#import "YJNSFoundationOther.h"
#import "YJNSHttp.h"
#import "YJNSRouterNode.h"
#import "YJDispatch.h"
#import "YJSystemOther.h"

@interface YJNSURLRouter ()

@property (nonatomic, strong) NSMutableDictionary<YJNSRouterURL, YJNSRouterNodeConfig *> *configDict;
@property (nonatomic, strong) NSMutableArray<YJNSRouterNode *> *nodeList;
@property (nonatomic, strong) NSCache<YJNSRouterURL, id> *nodeCache;

@end

@implementation YJNSURLRouter

+ (void)load {
    dispatch_after_main(2, ^{
        [YJNSURLRouterS configDict];
    });
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.nodeList = NSMutableArray.array;
        self.nodeCache = NSCache.new;
    }
    return self;
}

#pragma mark - 注册
- (void)registerNodeConfig:(YJNSRouterNodeConfig *)config {
    if (config.url) {
        [self.configDict setObject:config forKey:config.url];
    }
}

- (void)loadRouter {
    unsigned int classCount;
    Class *classes = objc_copyClassList(&classCount);
    SEL sel = @selector(loadRouter);
    for (int i = 0; i < classCount; i++) {
        Class cls = classes[i];
        if (class_getClassMethod(cls, sel)) {
            @warningPerformSelector([cls performSelector:sel])
        }
    }
    free(classes);
}

#pragma mark - 打开
- (BOOL)canOpenURL:(NSString *)url {
    YJNSRouterNodeConfig *config = [self.configDict objectForKey:url];
    return config != nil;
}

- (void)openURL:(NSString *)url {
    [self openURL:url options:nil completionHandler:nil];
}

- (void)openURL:(NSString *)url options:(NSDictionary *)options completionHandler:(dispatch_block_t)completion {
    NSAssert(NSThread.isMainThread, @"%@ %@ 需主线程调用", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    YJNSRouterURL rUrl = url;
    NSRange range = [rUrl rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        rUrl = [rUrl substringToIndex:range.location];
    }
    NSMutableDictionary *mOptions = [YJNSHttpAnalysis analysisParamsDecode:url].mutableCopy;
    if (options.count) [mOptions addEntriesFromDictionary:options];
    YJNSRouterNodeConfig *config = [self.configDict objectForKey:rUrl];
    [self openURL:rUrl options:mOptions config:config completionHandler:completion];
}

- (void)openURL:(YJNSRouterURL)url options:(NSDictionary *)options config:(YJNSRouterNodeConfig *)config completionHandler:(dispatch_block_t)completion {
    if (config) {
        id<YJNSURLRouterProtocol> node;
        if (config.handler) {
            node = config.handler(options, completion);
        } else {
            node = [self buildNodeWithConfig:config];
            if ([node respondsToSelector:@selector(reloadDataWithRouterOptions:)]) {
                [node reloadDataWithRouterOptions:options];
            }
            if ([node respondsToSelector:@selector(openRouterCompletionHandler:)]) {
                [node openRouterCompletionHandler:completion];
            } else {
                !completion?:completion();
            }
        }
        if (node) [self onlineNode:node config:config];
    } else if ([self.delegate canOpenUnregisteredURL:url]) {
        [self.delegate openUnregisteredURL:url options:options completionHandler:completion];
    }
}

- (id<YJNSURLRouterProtocol>)buildNodeWithConfig:(YJNSRouterNodeConfig *)config {
    id<YJNSURLRouterProtocol> node;
    if (config.cache) node = [self getCacheNodeWithConfig:config];
    if (!node && [config.cls respondsToSelector:@selector(newWithRouterURL:)]) {
        node = [config.cls newWithRouterURL:config.url];
    }
    if (!node) node = config.cls.new;
    if (config.cache) [self.nodeCache setObject:node forKey:config.url];
    return node;
}

- (id<YJNSURLRouterProtocol>)getCacheNodeWithConfig:(YJNSRouterNodeConfig *)config {
    id<YJNSURLRouterProtocol> cacheNode = [self.nodeCache objectForKey:config.url];
    if (!cacheNode) return nil;
    for (NSInteger i = self.nodeList.count - 1; i >= 0; i--) {
        YJNSRouterNode *node = [self.nodeList objectAtIndex:i];
        if (node.source) {
            if ([node.config isEqual:config] && [node.source isEqual:cacheNode]) return nil;
        } else {
            [self.nodeList removeObjectAtIndex:i];
        }
    }
    return cacheNode;
}

#pragma mark - 上下线
- (void)onlineNode:(id<YJNSURLRouterProtocol>)node config:(YJNSRouterNodeConfig *)config {
    [self.nodeList addObject:[[YJNSRouterNode alloc] initWithSource:node config:config]];
}

- (void)offlineNode:(id<YJNSURLRouterProtocol>)node {
    for (NSInteger i = self.nodeList.count - 1; i >= 0; i--) {
        YJNSRouterNode *item = [self.nodeList objectAtIndex:i];
        if (item.source) {
            if ([item.source isEqual:node]) {
                [self.nodeList removeObjectAtIndex:i];
                return;
            }
        } else {
            [self.nodeList removeObjectAtIndex:i];
        }
    }
}

#pragma mark - 数据交互
- (BOOL)sendData:(YJNSRouterDataID)dID options:(nullable NSDictionary *)options {
    BOOL result = NO;
    for (NSInteger i = self.nodeList.count - 1; i >= 0; i--) {
        YJNSRouterNode *node = [self.nodeList objectAtIndex:i];
        if ([node.source respondsToSelector:@selector(receiveRouterData:options:)]) {
            result = [node.source receiveRouterData:dID options:options];
            if (result) return result;
        }
    }
    return result;
}

#pragma mark - getter
- (NSMutableDictionary<YJNSRouterURL,YJNSRouterNodeConfig *> *)configDict {
    if (!_configDict) {
        _configDict = NSMutableDictionary.dictionary;
        [self loadRouter];
    }
    return _configDict;
}

@end
