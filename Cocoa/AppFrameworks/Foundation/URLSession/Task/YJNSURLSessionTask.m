//
//  YJNSURLSessionTask.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSURLSessionTask.h"
#import "YJDispatch.h"

@interface YJNSURLSessionTask ()

@property (nonatomic) YJNSURLSessionTaskState state; ///< 任务状态

@end

@implementation YJNSURLSessionTask

+ (instancetype)taskWithRequest:(YJNSURLRequest *)request {
    YJNSURLSessionPool *sPool = YJNSURLSessionPoolS;
    YJNSURLSessionTask *task = sPool.poolDict[request.identifier];
    if (!task) {
        task = [[self alloc] init];
        sPool.poolDict[request.identifier] = task;
    }
    task.request = request;
    return task;
}

#pragma mark - getter & setter
- (YJNSURLSessionTaskSuccess)success {
    @weakSelf
    YJNSURLSessionTaskSuccess block = ^(id data) {
        @strongSelf
        if (self.state == YJNSURLSessionTaskStateRunning) {
            self.state = YJNSURLSessionTaskStateSuccess;
            if (_success && self.request.source) {
                if (self.request.responseModelClass && [data isKindOfClass:[NSDictionary class]]) {
                    data = [[self.request.responseModelClass alloc] initWithModelDictionary:data];
                }
                _success(data);
            }
        }
    };
    return block;
}

- (YJNSURLSessionTaskFailure)failure {
    @weakSelf
    YJNSURLSessionTaskFailure block = ^(NSError *error) {
        @strongSelf
        NSLog(@"%@网络请求出错<<<<<<<<<<<<<<<%@", self.request.identifier, error);
        if (self.state == YJNSURLSessionTaskStateRunning) {
            self.state = YJNSURLSessionTaskStateFailure;
            if (_failure && self.request.source) {
                _failure(error);
            }
        }
    };
    return block;
}

#pragma mark -
- (instancetype)completionHandler:(YJNSURLSessionTaskSuccess)success failure:(YJNSURLSessionTaskFailure)failure {
    self.success = success;
    self.failure = failure;
    return self;
}

- (void)resume {
    NSLog(@"%@发出网络请求>>>>>>>>>>>>>>>%@", self.request.identifier, self.request.requestModel.modelDictionary);
    self.state = YJNSURLSessionTaskStateRunning;
    self.needResume = NO;
}

- (void)suspend {
    NSLog(@"%@暂停网络请求<<<<<<<<<<<<<<<", self.request.identifier);
    self.state = YJNSURLSessionTaskStateSuspended;
}

- (void)cancel {
    NSLog(@"%@取消网络请求<<<<<<<<<<<<<<<", self.request.identifier);
    self.state = YJNSURLSessionTaskStateCanceling;
    if (!self.request.supportResume) {
        [YJNSURLSessionPoolS.poolDict removeObjectForKey:self.request.identifier];
    }
}

@end
