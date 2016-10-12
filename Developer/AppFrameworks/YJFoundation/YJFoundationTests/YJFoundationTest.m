//
//  YJFoundationTest.m
//  YJFoundation
//
//  Created by admin on 2016/10/12.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJNSDirectory.h"

@interface YJFoundationTest : XCTestCase

@end

@implementation YJFoundationTest

- (void)testExample {
    NSLog(@"应用沙盒根路径:%@", YJNSDirectoryS.homePath);
    NSLog(@"Documents目录:%@", YJNSDirectoryS.documentPath);
    NSLog(@"Library目录:%@", YJNSDirectoryS.libraryPath);
    NSLog(@"Cache目录:%@", YJNSDirectoryS.cachesPath);
    NSLog(@"Temp目录:%@", YJNSDirectoryS.tempPath);
    
    NSArray *file = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:YJNSDirectoryS.homePath error:nil];
    NSLog(@"%@", file);
}


@end
