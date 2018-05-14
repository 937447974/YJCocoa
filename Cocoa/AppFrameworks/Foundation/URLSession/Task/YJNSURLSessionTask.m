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

@property (nonatomic) YJNSURLSessionTaskState state;
@property (nonatomic) BOOL needResume;
@property (nonatomic, strong) YJNSURLRequest *request;
@property (nonatomic, copy) YJNSURLSessionTaskSuccess success;
@property (nonatomic, copy) YJNSURLSessionTaskFailure failure;

@end

@implementation YJNSURLSessionTask

+ (instancetype)taskWithRequest:(YJNSURLRequest *)request {
    NSMutableDictionary *sPool = YJNSURLSessionPoolS;
    YJNSURLSessionTask *task = [sPool objectForKey:request.identifier];
    if (!task) {
        task = [[self alloc] init];
        [sPool setObject:task forKey:request.identifier];
        task.mainQueue = YES;
    }
    task.request = request;
    return task;
}

#pragma mark - business
- (instancetype)completionHandler:(YJNSURLSessionTaskSuccess)success failure:(YJNSURLSessionTaskFailure)failure {
    @weakSelf
    self.success = ^(id data) {
        @strongSelf
        if (self.state == YJNSURLSessionTaskStateRunning) {
            self.state = YJNSURLSessionTaskStateSuccess;
            if (success && self.request.source) {
                data = [self responseModelWithDictionary:data];
                self.mainQueue ? dispatch_async_main(^{success(data);}) : success(data);
            }
        }
    };
    self.failure = ^(NSError *error) {
        @strongSelf
#if DEBUG
        NSLog(@"%@网络请求出错<<<<<<<<<<<<<<<%@", self.request.identifier, error);
#endif
        self.needResume = YES;
        if (self.state == YJNSURLSessionTaskStateRunning) {
            self.state = YJNSURLSessionTaskStateFailure;
            if (failure && self.request.source) failure(error);
        }
    };
    return self;
}

- (void)resume {
#if DEBUG
    NSLog(@"%@发出网络请求>>>>>>>>>>>>>>>%@", self.request.identifier, self.request.requestModel.modelDictionary);
#endif
    self.state = YJNSURLSessionTaskStateRunning;
    self.needResume = NO;
}

- (void)suspend {
#if DEBUG
    NSLog(@"%@暂停网络请求<<<<<<<<<<<<<<<", self.request.identifier);
#endif
    self.state = YJNSURLSessionTaskStateSuspended;
}

- (void)cancel {
#if DEBUG
    NSLog(@"%@取消网络请求<<<<<<<<<<<<<<<", self.request.identifier);
#endif
    self.state = YJNSURLSessionTaskStateCanceling;
    self.needResume = NO;
    if (!self.request.supportResume) {
        [YJNSURLSessionPoolS removeObjectForKey:self.request.identifier];
    }    
}

- (id)responseModelWithDictionary:(NSDictionary *)md {
    if (self.request.responseModelClass && [md isKindOfClass:[NSDictionary class]]) {
        return [[self.request.responseModelClass alloc] initWithModelDictionary:md];
    }
    return md;
}

@end
