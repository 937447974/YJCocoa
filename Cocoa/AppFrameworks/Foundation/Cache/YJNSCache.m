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

@interface YJNSCache ()

@property (nonatomic, strong) NSMutableSet *cacheSet;

@end

@implementation YJNSCache

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cacheSet = NSMutableSet.set;
    }
    return self;
}

#pragma mark - super
- (id)objectForKey:(id)key {
    id obj = [super objectForKey:key];
    if (!obj) {
        [self.cacheSet removeObject:key];
    }
    return obj;
}

- (void)setObject:(id)obj forKey:(id)key {
    [super setObject:obj forKey:key];
    [self.cacheSet addObject:key];
}

- (void)setObject:(id)obj forKey:(id)key cost:(NSUInteger)g {
    [super setObject:obj forKey:key cost:g];
    [self.cacheSet addObject:key];
}

- (void)removeObjectForKey:(id)key {
    [super removeObjectForKey:key];
    [self.cacheSet removeObject:key];
}

- (void)removeAllObjects {
    [super removeAllObjects];
    [self.cacheSet removeAllObjects];
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
