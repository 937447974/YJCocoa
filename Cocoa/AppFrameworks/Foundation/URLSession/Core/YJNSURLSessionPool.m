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

- (YJNSCache<NSString *,YJNSURLSessionTask *> *)cache {
    if (!_cache) {
        _cache = YJNSCache.new;
        _cache.delegate = self;
    }
    return _cache;
}

#pragma mark - NSCacheDelegate
- (void)cache:(NSCache *)cache willEvictObject:(YJNSURLSessionTask *)task {
    switch (task.state) {
        case YJNSURLSessionTaskStateDefault:
        case YJNSURLSessionTaskStateRunning: {
            dispatch_async_default(^{
                [cache setObject:task forKey:task.request.identifier];
            });
        } break;
        default: break;
    }
}

@end
