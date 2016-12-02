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

YJNSHTTPMethod const YJNSHTTPMethodGET = @"GET";
YJNSHTTPMethod const YJNSHTTPMethodPOST = @"POST";

@implementation YJNSURLRequest

#pragma mark - init
+ (instancetype)requestWithSource:(NSObject *)source {
    YJNSURLRequest *request = [[self alloc] init];
    request -> _source = source;
    request -> _HTTPMethod = YJNSHTTPMethodGET;
    return request;
}

+ (instancetype)requestWithSource:(NSObject *)source HTTPBody:(id<YJNSHTTPBodyProtocol>)body {
    YJNSURLRequest *request = [self requestWithSource:source];
    request.HTTPBody = body;
    return request;
}

#pragma mark - getter & setter
- (NSString *)identifier {
    return [NSString stringWithFormat:@"%@-%@", NSStringFromClass(((NSObject *)self.source).class), self.URL];
}

@end
