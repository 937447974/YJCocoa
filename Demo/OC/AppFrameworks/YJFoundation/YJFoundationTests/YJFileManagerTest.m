//
//  YJFileManagerTest.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <YJCocoa/YJCocoa-Swift.h>

@interface YJFileManagerTest : XCTestCase

@end

@implementation YJFileManagerTest

- (void)testExample {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documentPath = YJDirectory.shared.documentPath;
    
    NSString *filePath1 = [documentPath stringByAppendingPathComponent:@"test.txt"];
    NSString *filePath2 = [documentPath stringByAppendingPathComponent:@"test/1.txt"];
    
    NSError *error;
    [@"阳君；937447974" writeToFile:filePath1 atomically:YES encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"%@", error);
    NSLog(@"%@", [fm subpathsOfDirectoryAtPath:YJDirectory.shared.documentPath error:nil]);
    [YJFileManager moveItemWithFromePath:filePath1 toPath:filePath2 error:&error];
    NSLog(@"%@", error);
    NSLog(@"%@", [fm subpathsOfDirectoryAtPath:documentPath error:nil]);
    NSLog(@"%@", error);
}

@end
