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
#import "YJDispatch.h"

@interface YJURLSessionTest : XCTestCase

@end

@implementation YJURLSessionTest

- (void)testExample {
    YJTestHTTPBody *body = [[YJTestHTTPBody alloc] init];
    body.name = @"阳君";
    body.qq = @"557445088";
    __weakSelf
    [[[YJTestURLSessionTask taskWithRequest:[YJTestURLRequest requestWithSource:self HTTPBody:body]] completionHandler:^(id data) {
        __strongSelf
        YJTestModel *model = data;
        NSLog(@"获取服务器数据:%@", model.modelDictionary);
        [[YJTestURLSessionTask taskWithRequest:[YJTestURLRequest requestWithSource:strongSelf]] cancel]; // 取消请求
    } failure:^(NSError *error) {
        __strongSelf
        [YJTestURLSessionTask taskWithRequest:[YJTestURLRequest requestWithSource:strongSelf]].request.supportResume = YES; // 开启断网重连
        [YJNSURLSession resumeAllNeedTask];// 断网重连
    }] resume]; // 发出请求
}

@end
