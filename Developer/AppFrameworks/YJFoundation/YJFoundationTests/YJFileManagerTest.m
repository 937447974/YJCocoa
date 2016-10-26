//
//  YJFileManagerTest.m
//  YJFoundation
//
//  Created by admin on 2016/10/26.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJFoundation.h"

@interface YJFileManagerTest : XCTestCase

@end

@implementation YJFileManagerTest

- (void)testExample {
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *filePath1 = [YJNSDirectoryS.documentPath stringByAppendingPathComponent:@"test.txt"];
    NSString *filePath2 = [YJNSDirectoryS.documentPath stringByAppendingPathComponent:@"test/1.txt"];
    
    NSError *error;
    BOOL result= [@"阳君；937447974" writeToFile:filePath1 atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    NSLogS([fm subpathsOfDirectoryAtPath:YJNSDirectoryS.documentPath error:nil]);
    
    result = [fm moveSafeItemAtPath:filePath1 toPath:filePath2 error:&error];
    
    NSLogS([fm subpathsOfDirectoryAtPath:YJNSDirectoryS.documentPath error:nil]);
}

@end
