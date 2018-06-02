//
//  YJTestURLSessionTask.m
//  YJFoundation
//
//  Created by 阳君 on 2016/11/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJTestURLSessionTask.h"

@implementation YJTestURLSessionTask

- (void)resume {
    [super resume];
    NSLog(@"请求方式：%@", self.request.requestMethod);
    if (random()%4 == 1) {
        NSDictionary *jsonDict = @{@"desc": @"请求成功"};
        self.success([[self.request.responseModelClass alloc] initWithModelDictionary:jsonDict]);
    } else {
        self.failure([NSError errorWithDomain:@"网络错误测试" code:NSURLErrorTimedOut userInfo:nil]);
    }    
}

@end
