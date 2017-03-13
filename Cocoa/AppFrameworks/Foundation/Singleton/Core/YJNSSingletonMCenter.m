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

#import <UIKit/UIKit.h>
#import "YJNSSingletonMCenter.h"
#import "YJNSFoundationOther.h"
#import "YJDispatch.h"

@interface YJNSSingletonMCenter() {
    pthread_mutex_t _lock;
}

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *strongDict; ///< 随应用一直存在的单例
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *weakDict;   ///< 内存警告时会回收的单例

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

#pragma mark - (-)
- (instancetype)init {
    self = [super init];
    if (self) {
        self.strongDict = [NSMutableDictionary dictionary];
        self.weakDict = [NSMutableDictionary dictionary];
        pthread_mutex_init(&_lock, NULL);
        // 内存监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
}

#pragma mark 内存警告
- (void)didReceiveMemoryWarning {
    @synchronized_pthread (_lock)
    [self.weakDict removeAllObjects];
}

#pragma mark 注册单例辅助方法
- (id)registerSingleton:(NSMutableDictionary<NSString *, id> *)dict forClass:(Class)sClass forIdentifier:(NSString *)identifier {
    id singleton;
    while (!singleton) {
        @synchronized_pthread_try(_lock) {
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

#pragma mark - 注册strong单例
- (id)registerStrongSingleton:(Class)sClass {
    return [self registerStrongSingleton:sClass forIdentifier:YJNSStringFromClass(sClass)];
}

- (id)registerStrongSingleton:(Class)sClass forIdentifier:(NSString *)identifier {
    return [self registerSingleton:self.strongDict forClass:sClass forIdentifier:identifier];
}

#pragma mark - 注册weak单例
- (id)registerWeakSingleton:(Class)sClass {
    return [self registerWeakSingleton:sClass forIdentifier:YJNSStringFromClass(sClass)];
}

- (id)registerWeakSingleton:(Class)sClass forIdentifier:(NSString *)identifier {
    return [self registerSingleton:self.weakDict forClass:sClass forIdentifier:identifier];
}

#pragma mark - 移除weak单例
- (void)removeWeakSingleton:(Class)sClass {
    @synchronized_pthread (_lock)
    [self.weakDict removeObjectForKey:YJNSStringFromClass(sClass)];
}

- (void)removeWeakSingletonWithIdentifier:(NSString *)identifier {
    @synchronized_pthread (_lock)
    [self.weakDict removeObjectForKey:identifier];
}

@end
