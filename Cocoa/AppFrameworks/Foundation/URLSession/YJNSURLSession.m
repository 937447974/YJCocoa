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
    // 这里可做短线重连，网络管理等相关工作
    YJNSURLSessionTask *task = [[YJNSURLSessionTask alloc] init];
    task.request = request;
    return task;
}

@end
