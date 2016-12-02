//
//  YJHttpTest.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJFoundation.h"

@interface YJHttpTest : XCTestCase

@end

@implementation YJHttpTest

- (void)testExample {
    NSMutableString *http = [NSMutableString stringWithString:[YJNSHttpAssembly assemblyHttp:@"https://www.baidu.com/s" params:@{@"name":@"阳君", @"qq":@"937447974"}]];
    [http appendString:@"#point"]; // 锚点
    NSLog(@"%@", http);
    NSLog(@"%@", [YJNSHttpAnalysis analysisParams:http]);
    NSLog(@"%@", [YJNSHttpAnalysis analysisParams:http forKey:@"name"]);
}

@end
