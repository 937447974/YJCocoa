//
//  URLSessionTest.m
//  YJFoundationTests
//
//  Created by 阳君 on 2019/6/21.
//  Copyright © 2019 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <YJCocoa/YJCocoa.h>
#import <YJCocoa/YJCocoa-Swift.h>
#import "YJFoundationTests-Swift.h"

@interface URLSessionTest : XCTestCase
@end
@implementation URLSessionTest

- (void)testURLSession {
    YJTestURLRequestModel *requestModel = [[YJTestURLRequestModel alloc] init];
    requestModel.name = @"阳君";
    requestModel.qq = @"557445088";
    YJURLRequest *request = [[YJURLRequest alloc] initWithSource:nil url:@"https://github.com/937447974/YJCocoa" method:YJURLRequestMethodPost reqModel:requestModel respModel:YJTestURLResponseModel.new];
   [[[YJTestURLSessionTask taskWith:request] completionHandlerWithSuccess:^(YJTestURLResponseModel *respModel) {
         NSLog(@"获取服务器数据:%@", respModel.desc);
    } failure:^(NSError * error) {
        NSLog(@"%@", error);
    }] resume];
}

@end
