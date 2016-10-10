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

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    [super tearDown];

}

- (void)testExample {
    NSString *http = [YJNSHttpAssembly assemblyHttp:@"https://www.baidu.com/s" params:@{@"name":@"阳君", @"qq":@"937447974"}];
    NSLog(@"%@", http);
    NSLog(@"%@", [YJNSHttpAnalysis analysisParams:http]);
    NSLog(@"%@", [YJNSHttpAnalysis analysisParams:http forKey:@"name"]);
}

@end
