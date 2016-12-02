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

@implementation YJNSURLSessionTask

#pragma mark - getter & setter
- (YJNSURLSessionTaskSuccess)success {
    __weakSelf
    YJNSURLSessionTaskSuccess block = ^(__kindof NSObject *data, NSURLResponse *response) {
        __strongSelf
        strongSelf -> _state = YJNSURLSessionTaskStateSuccess;
        if (strongSelf.success && strongSelf.request.source) strongSelf.success(data, response);
    };
    return block;
}

- (YJNSURLSessionTaskFailure)failure {
    __weakSelf
    YJNSURLSessionTaskFailure block = ^(NSError *error) {
        __strongSelf
        NSLog(@"%@", error);
        strongSelf -> _state = YJNSURLSessionTaskStateFailure;
        if (strongSelf.failure && strongSelf.request.source) strongSelf.failure(error);
    };
    return block;
}

- (BOOL)needResume {
    return _needResume && self.request.supportResume;
}

#pragma mark -
- (instancetype)completionHandler:(YJNSURLSessionTaskSuccess)success failure:(YJNSURLSessionTaskFailure)failure {
    self.success = success;
    self.failure = failure;
    return self;
}

- (void)resume {
    NSLog(@"%@发出网络请求>>>>>>>>>>>>>>>%@", self.request.identifier, self.request.HTTPBody.modelDictionary);
    self -> _state = YJNSURLSessionTaskStateRunning;
    self.needResume = NO;
}

- (void)suspend {
    NSLog(@"%@暂停网络请求<<<<<<<<<<<<<<<", self.request.identifier);
    self -> _state = YJNSURLSessionTaskStateSuspended;
}

- (void)cancel {
    NSLog(@"%@取消网络请求<<<<<<<<<<<<<<<", self.request.identifier);
    self -> _state = YJNSURLSessionTaskStateCanceling;
}

@end
