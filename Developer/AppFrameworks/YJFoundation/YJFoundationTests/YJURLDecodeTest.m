//
//  YJURLDecodeTest.m
//  YJFoundation
//
//  Created by admin on 2016/12/19.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJNSURLCode.h"

@interface YJURLDecodeTest : XCTestCase

@end

@implementation YJURLDecodeTest

- (void)testExample {
    NSString *code = @"&#?阳君937447974:/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`";
    
    NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)code, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), kCFStringEncodingUTF8);
    NSLog(@"%@", result);
    result = YJNSURLEncode(code);
    NSLog(@"%@", result);
    NSLog(@"%@", YJNSURLDecode(result));
}

@end
