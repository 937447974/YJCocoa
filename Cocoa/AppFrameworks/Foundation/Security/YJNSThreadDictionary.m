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

@interface YJNSThreadDictionary () {
    pthread_mutex_t _lock;
}
@end

@implementation YJNSThreadDictionary

- (instancetype)init {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!(anObject && aKey)) return;
    @synchronized_pthread(self->_lock)
    [super setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey {
    if (!aKey) return;
    @synchronized_pthread(self->_lock)
    [super removeObjectForKey:aKey];
}

- (id)objectForKey:(id)aKey {
    if (!aKey) return nil;
    @synchronized_pthread(self->_lock)
    return [super objectForKey:aKey];
}

@end
