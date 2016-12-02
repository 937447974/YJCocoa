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
    if (random()%4 == 1) {
        NSDictionary *jsonDict = @{@"desc": @"请求成功"};
        self.success([[self.request.HTTPBody.responseClass alloc] initWithModelDictionary:jsonDict]);
    } else {
        self.needResume = YES;
        self.failure([NSError errorWithDomain:@"网络错误测试" code:NSURLErrorTimedOut userInfo:nil]);
    }    
}

@end
