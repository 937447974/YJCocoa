//
//  YJNSURLRequest.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/11/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSURLRequest.h"

YJNSURLRequestMethod const YJNSURLRequestMethodGET = @"GET";
YJNSURLRequestMethod const YJNSURLRequestMethodPOST = @"POST";

@implementation YJNSURLRequest

#pragma mark - init
+ (instancetype)requestWithSource:(NSObject *)source {
    YJNSURLRequest *request = [[self alloc] init];
    request -> _source = source;
    return request;
}

+ (instancetype)requestWithSource:(NSObject *)source requestModel:(id<YJNSURLRequestModel>)requestModel {
    YJNSURLRequest *request = [self requestWithSource:source];
    request -> _requestModel = requestModel;
    return request;
}

#pragma mark - getter & setter
- (NSString *)identifier {
    return _identifier ? _identifier : [NSString stringWithFormat:@"%@-%@", NSStringFromClass(((NSObject *)self.source).class), self.URL];
}

- (YJNSURLRequestMethod)requestMethod {
    [self doesNotRecognizeSelector:_cmd];
    return YJNSURLRequestMethodGET;
}

- (Class)responseModelClass {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
