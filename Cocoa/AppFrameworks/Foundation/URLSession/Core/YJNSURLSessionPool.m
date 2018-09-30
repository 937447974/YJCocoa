//
//  YJNSURLSessionPool.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2018/7/19.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSURLSessionPool.h"
#import "YJDispatch.h"

@implementation YJNSURLSessionPool

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cache = YJNSCache.new;
        self.cache.delegate = self;
    }
    return self;
}

#pragma mark - NSCacheDelegate
- (void)cache:(NSCache *)cache willEvictObject:(YJNSURLSessionTask *)task {
    switch (task.state) {
        case YJNSURLSessionTaskStateDefault:
        case YJNSURLSessionTaskStateRunning: {
            dispatch_after_default(0.2, ^{
                [cache setObject:task forKey:task.request.identifier];
            });
        } break;
        default: break;
    }
}

@end
