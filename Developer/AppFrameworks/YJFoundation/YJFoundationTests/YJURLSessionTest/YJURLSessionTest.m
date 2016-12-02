//
//  YJURLSessionTest.m
//  YJFoundation
//
//  Created by admin on 2016/11/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJNSURLSession.h"
#import "YJTestURLSessionTask.h"
#import "YJTestURLRequest.h"
#import "YJTestHTTPBody.h"

@interface YJURLSessionTest : XCTestCase

@end

@implementation YJURLSessionTest

- (void)testExample {
    YJTestHTTPBody *body = [[YJTestHTTPBody alloc] init];
    body.name = @"阳君";
    body.qq = @"557445088";
    [[[YJNSURLSession taskWithRequest:[YJTestURLRequest requestWithSource:self HTTPBody:body]] completionHandler:^(id data) {
        YJTestModel *model = data;
        NSLog(@"获取服务器数据:%@", model.modelDictionary);
        [[YJNSURLSession taskWithRequest:[YJTestURLRequest requestWithSource:self]] cancel]; // 取消请求
    } failure:^(NSError *error) {
        [YJNSURLSession resumeAllNeedTask];// 断网重连
    }] resume];
}

@end
