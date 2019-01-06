//
//  YJSingletonMCenter.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSSingletonMCenter.h"
#import "YJNSFoundationOther.h"
#import "YJPthread.h"
#import "YJNSLog.h"

@interface YJNSSingletonMCenter() <NSCacheDelegate> {
    pthread_mutex_t _lock;
}

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *strongDict; ///< 随应用一直存在的单例
@property (nonatomic, strong) NSCache<NSString *, id> *weakCache; ///< weak缓存池

@end

@implementation YJNSSingletonMCenter

#pragma mark - (+)
+ (YJNSSingletonMCenter *)defaultCenter {
    static YJNSSingletonMCenter *singletonMC;
    if (!singletonMC) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            singletonMC = [[YJNSSingletonMCenter alloc] init];
        });
    }
    return singletonMC;
}

#pragma mark - super
- (instancetype)init {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
        self.strongDict = NSMutableDictionary.dictionary;
        self.weakCache = NSCache.new;
#if DEBUG
        self.weakCache.delegate = self;
#endif
    }
    return self;
}

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
}

#pragma mark - 注册单例
- (id)registerStrongSingleton:(Class)sClass forIdentifier:(NSString *)identifier {
    identifier = identifier ?: YJNSStringFromClass(sClass);
    return [self registerSingleton:self.strongDict forClass:sClass forIdentifier:identifier];
}

- (id)registerWeakSingleton:(Class)sClass forIdentifier:(NSString *)identifier {
    identifier = identifier ?: YJNSStringFromClass(sClass);
    return [self registerSingleton:(NSMutableDictionary *)self.weakCache forClass:sClass forIdentifier:identifier];
}

- (id)registerSingleton:(NSMutableDictionary<NSString *, id> *)dict forClass:(Class)sClass forIdentifier:(NSString *)identifier {
    id singleton;
    while (!singleton) {
        @synchronized_pthread_try(self -> _lock) {
            singleton = [dict objectForKey:identifier];
            if (!singleton) {
                singleton = [[sClass alloc] init];
                [dict setObject:singleton forKey:identifier];
            }
        } @synchronized_pthread_try_else {
            usleep(5000); //5ms
        } @synchronized_pthread_try_end
    }
    return singleton;
}

#pragma mark - 移除weak单例
- (void)removeWeakSingleton:(Class)sClass {
    [self removeWeakSingletonWithIdentifier:YJNSStringFromClass(sClass)];
}

- (void)removeWeakSingletonWithIdentifier:(NSString *)identifier {
    @synchronized_pthread (self -> _lock)
    [self.weakCache removeObjectForKey:identifier];
}

#pragma mark - NSCacheDelegate
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    YJLogVerbose(@"YJNSSingleton 释放：%@", obj);
}

@end
