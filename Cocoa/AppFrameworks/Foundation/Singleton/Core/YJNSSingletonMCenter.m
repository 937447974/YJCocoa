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

@interface YJNSSingletonMutex : NSObject{
    pthread_mutex_t _lock;
}
@end

@implementation YJNSSingletonMutex
- (instancetype)init{
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}
- (void)dealloc {pthread_mutex_destroy(&_lock);}
- (void)lock {pthread_mutex_lock(&_lock);}
- (void)unLock {pthread_mutex_unlock(&_lock);}
@end

#pragma mark -
@interface YJNSSingletonMCenter() <NSCacheDelegate> {
    pthread_mutex_t _lock;
}

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *strongDict;
@property (nonatomic, strong) NSMutableDictionary<NSString *, YJNSSingletonMutex *> *mutexDict;
@property (nonatomic, strong) NSCache<NSString *, id> *weakCache;

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
        self.mutexDict = NSMutableDictionary.dictionary;
        self.weakCache = NSCache.new;
        self.weakCache.delegate = self;
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

- (id)registerSingleton:(NSMutableDictionary<NSString *, id> *)dict forClass:(Class)cls forIdentifier:(NSString *)identifier {
    YJNSSingletonMutex *mutex = [self getMutexWithIdentifier:identifier];
    [mutex lock];
    id singleton = [dict objectForKey:identifier];
    if (!singleton) {
        YJLogVerbose(@"[YJCocoa] YJNSSingleton 创建单例：%@-%@", YJNSStringFromClass(cls),identifier);
        singleton = [[cls alloc] init];
        [dict setObject:singleton forKey:identifier];
    }
    [mutex unLock];
    return singleton;
}

- (YJNSSingletonMutex *)getMutexWithIdentifier:(NSString *)identifier {
    @synchronized_pthread (self -> _lock)
    YJNSSingletonMutex *mutex = [self.mutexDict objectForKey:identifier];
    if (!mutex) {
        mutex = YJNSSingletonMutex.new;
        [self.mutexDict setObject:mutex forKey:identifier];
    }
    return mutex;
}

#pragma mark - 移除weak单例
- (void)removeWeakSingleton:(Class)sClass {
    @synchronized_pthread (self -> _lock)
    [self removeWeakSingletonWithIdentifier:YJNSStringFromClass(sClass)];
}

- (void)removeWeakSingletonWithIdentifier:(NSString *)identifier {
    @synchronized_pthread (self -> _lock)
    [self.weakCache removeObjectForKey:identifier];
}

#pragma mark - NSCacheDelegate
- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    YJLogVerbose(@"[YJCocoa] YJNSSingleton 释放：%@", obj);
}

@end
