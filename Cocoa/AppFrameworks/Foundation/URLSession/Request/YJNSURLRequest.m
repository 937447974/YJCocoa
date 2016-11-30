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

+ (instancetype)requestWithSource:(NSObject *)source {
    YJNSURLRequest *request = [[self alloc] init];
    request.source = source;
    request.HTTPMethod = YJNSHTTPMethodGET;
    return request;
}

- (NSString *)identifier {
    if (_identifier) return _identifier;
    return [NSString stringWithFormat:@"%@-%@", NSStringFromClass(self.source.class), self.URL];
}

@end
