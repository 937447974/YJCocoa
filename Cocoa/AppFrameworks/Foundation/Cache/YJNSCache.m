//
//  YJNSCache.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/7/13.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSCache.h"
#import "YJPthread.h"

@interface YJNSCache () {
    pthread_mutex_t _lock;
}

@property (nonatomic, strong) NSMutableSet *cacheSet;

@end

@implementation YJNSCache

- (instancetype)init {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
        self.cacheSet = NSMutableSet.set;
    }
    return self;
}

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
}

#pragma mark - super
- (id)objectForKey:(id)key {
    @synchronized_pthread (self->_lock)
    id obj = [super objectForKey:key];
    if (!obj) {
        [self.cacheSet removeObject:key];
    }
    return obj;
}

- (void)setObject:(id)obj forKey:(id)key {
    @synchronized_pthread (self->_lock)
    [super setObject:obj forKey:key];
    [self.cacheSet addObject:key];
}

- (void)setObject:(id)obj forKey:(id)key cost:(NSUInteger)g {
    [super setObject:obj forKey:key cost:g];
    [self.cacheSet addObject:key];
}

- (void)removeObjectForKey:(id)key {
    @synchronized_pthread (self->_lock)
    [super removeObjectForKey:key];
    [self.cacheSet removeObject:key];
}

- (void)removeAllObjects {
    @synchronized_pthread (self->_lock)
    [super removeAllObjects];
    [self.cacheSet removeAllObjects];
}

#pragma mark - Getter
- (NSUInteger)count {
    return self.allKeys.count;
}

- (NSArray *)allKeys {
    for (id key in self.cacheSet.allObjects) {
        [self objectForKey:key];
    }
    return self.cacheSet.allObjects;
}

- (NSArray *)allValues {
    NSMutableArray *allValues = NSMutableArray.array;
    for (id key in self.cacheSet.allObjects) {
        id obj = [self objectForKey:key];
        if (obj) [allValues addObject:obj];
    }
    return allValues;
}

@end
