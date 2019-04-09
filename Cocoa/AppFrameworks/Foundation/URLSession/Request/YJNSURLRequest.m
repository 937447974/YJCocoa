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

@interface YJNSURLRequest ()

@property (nonatomic, weak, readwrite) id source;

@property (nonatomic, copy, readwrite) NSString *url;
@property (nonatomic, readwrite) YJNSURLRequestMethod requestMethod;
@property (nonatomic, strong, readwrite) NSObject *requestModel;

@property (nonatomic, readwrite) Class responseModelClass;

@end

@implementation YJNSURLRequest

+ (instancetype)requestWithSource:(id)source url:(NSString *)url reqMethod:(YJNSURLRequestMethod)reqMethod reqModel:(NSObject *)reqModel respModelClass:(Class)respModelClass {
    YJNSURLRequest *request = [[self alloc] init];
    request.source = source ?: self;
    request.url = url;
    request.requestMethod = reqMethod;
    request.requestModel = reqModel;
    request.responseModelClass = respModelClass;
    NSMutableString *identifier = [NSMutableString stringWithString:url];
    if ([source isKindOfClass:NSObject.class]) {
        [identifier appendFormat:@"-%@", NSStringFromClass(((NSObject *)source).class)];
    }
    if (reqModel) {
        [identifier appendFormat:@"-%@", reqModel];
    }
    request.identifier = identifier;
    return request;
}


@end
