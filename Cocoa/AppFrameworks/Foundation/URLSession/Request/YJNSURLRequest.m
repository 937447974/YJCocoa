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

@interface YJNSURLRequest ()

@property (nonatomic, weak) id source;

@property (nonatomic, copy) NSString *URL;
@property (nonatomic, copy) YJNSURLRequestMethod requestMethod;
@property (nonatomic, strong) NSObject *requestModel;

@property (nonatomic) Class responseModelClass;

@end

@implementation YJNSURLRequest

#pragma mark - init
+ (instancetype)requestWithSource:(id)source url:(NSString *)url reqMethod:(YJNSURLRequestMethod)reqMethod reqModel:(NSObject *)reqModel respModelClass:(Class)respModelClass{
    YJNSURLRequest *request = [[self alloc] init];
    request.source = source;
    request.URL = url;
    request.requestMethod = reqMethod;
    request.requestModel = reqModel;
    request.responseModelClass = respModelClass;
    return request;
}

#pragma mark - getter & setter
- (NSString *)identifier {
    if (!_identifier) {
        _identifier = [NSString stringWithFormat:@"%@-%@", NSStringFromClass(((NSObject *)self.source).class), self.URL];
    }
    return _identifier;
}

@end
