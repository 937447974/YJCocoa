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

@interface YJNSSingletonModel : NSObject{
    pthread_mutex_t _lock;
}
@property (nonatomic, strong) id obj;
@end

@implementation YJNSSingletonModel
- (instancetype)init{
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}
- (void)dealloc {pthread_mutex_destroy(&_lock);}
- (id)objectForClass:(Class)cls forIdentifier:(NSString *)identifier {
    if (self.obj) return self.obj;
    @synchronized_pthread (self -> _lock)
    if (!self.obj) {
        YJLogVerbose(@"[YJCocoa] 创建单例：%@-%@", YJNSStringFromClass(cls), identifier);
        self.obj = [[cls alloc] init];
    }
    return self.obj;
}
@end


#pragma mark -
@interface YJNSSingletonMCenter() <NSCacheDelegate> {
    pthread_mutex_t _lock;
}

@property (nonatomic, strong) NSMutableDictionary<NSString *, YJNSSingletonModel *> *strongDict;
@property (nonatomic, strong) NSCache<NSString *, YJNSSingletonModel *> *weakCache;

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

- (id)registerSingleton:(NSMutableDictionary *)dict forClass:(Class)cls forIdentifier:(NSString *)identifier {
    YJNSSingletonModel *model = [self getModel:dict withIdentifier:identifier];
    return [model objectForClass:cls forIdentifier:identifier];
}

- (YJNSSingletonModel *)getModel:(NSMutableDictionary *)dict withIdentifier:(NSString *)identifier  {
    @synchronized_pthread (self -> _lock)
    YJNSSingletonModel *model = [dict objectForKey:identifier];
    if (!model) {
        model = YJNSSingletonModel.new;
        [dict setObject:model forKey:identifier];
    }
    return model;
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
    YJLogVerbose(@"[YJCocoa] 释放：%@", obj);
}

@end
