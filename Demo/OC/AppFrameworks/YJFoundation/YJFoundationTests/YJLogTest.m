//
//  YJLogTest.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJFoundation.h"

@interface YJLogTest : XCTestCase

@end

@implementation YJLogTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSArray *array = [NSArray arrayWithObjects:@"阳君", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSSet *set = [NSSet setWithObjects:@"937447974", @"阳君", dict, nil];
    array = [NSArray arrayWithObjects:@"阳君", dict, set, nil];
    dict = [NSDictionary dictionaryWithObjectsAndKeys:array, @"name", @"937447974", @"qq", nil];
    NSLog(@"%@", dict);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
