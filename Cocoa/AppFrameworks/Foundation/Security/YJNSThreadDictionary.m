//
//  YJNSThreadDictionary.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/3/13.
//  Copyright © 2019年 YJCocoa. All rights reserved.
//

#import "YJNSThreadDictionary.h"
#import "NSMutableDictionary+YJSecurity.h"
#import "YJPthread.h"
#import <objc/runtime.h>

@interface YJNSThreadDictionary () {
    pthread_mutex_t _lock;
    NSMutableDictionary *_mDict;
}
@end

@implementation YJNSThreadDictionary

- (instancetype)init {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
        _mDict = NSMutableDictionary.dictionary;
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
        _mDict = [[NSMutableDictionary alloc] initWithCapacity:numItems];
    }
    return self;
}

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
}

#pragma mark - abstract class
- (NSUInteger)count {
    return _mDict.count;
}

- (NSEnumerator *)keyEnumerator {
    return _mDict.keyEnumerator;
}

- (id)objectForKey:(id)aKey {
    if (!aKey) return nil;
    @synchronized_pthread(self->_lock)
    return [_mDict objectForKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!(anObject && aKey)) return;
    @synchronized_pthread(self->_lock)
    [_mDict setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey {
    if (!aKey) return;
    @synchronized_pthread(self->_lock)
    [_mDict removeObjectForKey:aKey];
}

#pragma mark - aop
- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_mDict respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _mDict;
}

@end
