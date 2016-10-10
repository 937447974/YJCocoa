//
//  YJPerformSelectorTest.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJFoundation.h"

@interface YJPerformSelectorTest : XCTestCase

@end

@implementation YJPerformSelectorTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    [self performSelector:@selector(testPerformSelector1) withObjects:nil];
    [self performSelector:@selector(testPerformSelector2:withObject:withObject:) withObjects:@[@"1",@"2"]];
    YJNSPerformSelector *result = [self performSelector:@selector(testPerformSelector3:withObject:) withObjects:@[@"1",@"2"]];
    NSLog(@"%@", result.result);
}

- (void)testPerformSelector1 {
    NSLog(NSStringFromSelector(_cmd), nil);
}

- (void)testPerformSelector2:(id)object0 withObject:(id)object1 withObject:(id)object2 {
    NSLog(@"0:%@; 1:%@; 2:%@", object0, object1, object2);
}

- (NSString *)testPerformSelector3:(id)object1 withObject:(id)object2 {
    NSLog(@"0:%@; 1:%@; ", object1, object2);
    return @"阳君";
}

@end
