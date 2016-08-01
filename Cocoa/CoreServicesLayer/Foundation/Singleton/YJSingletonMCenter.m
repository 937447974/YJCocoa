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

#import "YJSingletonMCenter.h"
#import "YJFoundationOther.h"
#import <UIKit/UIKit.h>

@interface YJSingletonMCenter() {
    dispatch_queue_t _queue; // 串行队列
}
/** 随应用一直存在的单例*/
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *strongDict;
/** 内存警告时会回收的单例*/
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *weakDict;

@end

@implementation YJSingletonMCenter

#pragma mark - (+)
+ (YJSingletonMCenter *)defaultCenter {
    static YJSingletonMCenter *singletonMC;
    if (!singletonMC) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            singletonMC = [[YJSingletonMCenter alloc] init];
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
        // 串行队列
        _queue = dispatch_queue_create("YJSingletonMCenter", DISPATCH_QUEUE_SERIAL);
        // 内存监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

#pragma mark 内存警告
- (void)didReceiveMemoryWarning {
    // 无须考虑self释放，此为应用级单例，随应用一直存在
    dispatch_async(_queue, ^{
        [self.weakDict removeAllObjects];
    });
}

#pragma mark 注册单例辅助方法
- (id)registerSingleton:(NSMutableDictionary<NSString *, id> *)dict forClass:(Class)sClass forIdentifier:(NSString *)identifier {
    __block id singleton = [dict objectForKey:identifier];
    while (!singleton) {
        dispatch_sync(_queue, ^{
            singleton = [dict objectForKey:identifier];
            if (singleton) return; // 已存在直接返回
            // 未存在，初始化
            singleton = [[sClass alloc] init];
            [dict setObject:singleton forKey:identifier];
        });
    }
    return singleton;
}

#pragma mark - 注册strong单例
- (id)registerStrongSingleton:(Class)sClass {
    return [self registerStrongSingleton:sClass forIdentifier:YJStringFromClass(sClass)];
}

- (id)registerStrongSingleton:(Class)sClass forIdentifier:(NSString *)identifier {
    return [self registerSingleton:self.strongDict forClass:sClass forIdentifier:identifier];
}

#pragma mark - 注册weak单例
- (id)registerWeakSingleton:(Class)sClass {
    return [self registerWeakSingleton:sClass forIdentifier:YJStringFromClass(sClass)];
}

- (id)registerWeakSingleton:(Class)sClass forIdentifier:(NSString *)identifier {
    return [self registerSingleton:self.weakDict forClass:sClass forIdentifier:identifier];
}

#pragma mark - 移除weak单例
- (void)removeWeakSingleton:(Class)sClass {
    dispatch_sync(_queue, ^{
        [self.weakDict removeObjectForKey:YJStringFromClass(sClass)];
    });
}

- (void)removeWeakSingletonWithIdentifier:(NSString *)identifier {
    dispatch_sync(_queue, ^{
        [self.weakDict removeObjectForKey:identifier];
    });
}

@end
