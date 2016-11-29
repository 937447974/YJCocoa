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

@implementation YJNSURLSessionTask

#pragma mark - getter & setter
- (YJNSURLSessionTaskSuccess)success {
    if(!_success) {
        _success = ^(__kindof NSObject *data, NSURLResponse *response) { };
    }
    return _success;
}

- (YJNSURLSessionTaskFailure)failure {
    if(!_failure) {
        _failure = ^(NSError *error) {
            NSLog(@"%@", error);
        };
    }
    return _failure;
}

#pragma mark -
- (instancetype)completionHandler:(YJNSURLSessionTaskSuccess)success failure:(YJNSURLSessionTaskFailure)failure {
    self.success = success;
    self.failure = failure;
    return self;
}

- (void)resume {
    NSLog(@"%@发出网络请求>>>>>>>>>>>>>>>%@", self.request.identifier, self.request.HTTPBody.modelDictionary);
}

- (void)cancel {
    NSLog(@"%@取消网络请求<<<<<<<<<<<<<<<", self.request.identifier);
}

@end
