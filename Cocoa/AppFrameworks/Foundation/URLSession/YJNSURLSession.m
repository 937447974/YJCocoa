//
//  YJNSURLSession.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSURLSession.h"

@implementation YJNSURLSession

+ (YJNSURLSessionTask *)taskWithRequest:(YJNSURLRequest *)request {
    YJNSURLSessionPool *sPool = YJNSURLSessionPool.sharedPool;
    YJNSURLSessionTask *task = sPool.poolDict[request.identifier];
    if (!task) {
        task = [[YJNSURLSessionTask alloc] init];
        task.request = request;
        sPool.poolDict[request.identifier] = task;
    }
    return task;
}

+ (void)resumeAllFailedTask {
    NSArray *allEffectiveTask = [self allEffectiveTask];
    for (YJNSURLSessionTask *task in allEffectiveTask) {
        if (task.state == YJNSURLSessionTaskStateFailure) {
            [task resume];
        }
    }
}

+ (NSArray *)allEffectiveTask {
    YJNSURLSessionPool *sPool = YJNSURLSessionPool.sharedPool;
    NSMutableArray *allEffectiveTask = [NSMutableArray arrayWithCapacity:sPool.poolDict.count];
    NSMutableArray *removeKeyArray = [NSMutableArray arrayWithCapacity:sPool.poolDict.count];
    for (YJNSURLRequest *request in sPool.poolDict.allValues) {
        request.source ? [allEffectiveTask addObject:request] : [removeKeyArray addObject:request.identifier];
    }
    [sPool.poolDict removeObjectsForKeys:removeKeyArray];
    return allEffectiveTask;
}

@end
