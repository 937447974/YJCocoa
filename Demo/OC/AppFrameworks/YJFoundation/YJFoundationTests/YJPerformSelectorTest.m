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

- (void)testExample {
    [self performSelector:@selector(testPerform) withObjects:nil]; //方法不存在
    
    CGFloat result;
    [[self performSelector:@selector(testPerformSelector) withObjects:nil] getValue:&result];
    NSLog(@"%f\n ", result);
    
    BOOL result1 = [self performSelector:@selector(testPerformSelector1) withObjects:nil];
    NSLog(@"%d\n ", result1);
    result1 = [self performSelector:@selector(testPerformSelector1) withObjects:@[@"1",@"2"]];// 方法传入多参数
    NSLog(@"%d\n ", result1);
    
    id result2 = [self performSelector:@selector(testPerformSelector2:withObject:withObject:) withObjects:@[@"1",@"2"]];
    NSLog(@"%@\n ", result2);
    
    NSString *result3 = [self performSelector:@selector(testPerformSelector3:withObject:) withObjects:@[@"1",@"2"]];
    NSLog(@"%@\n ", result3);
}

- (CGFloat)testPerformSelector {
    NSLog(NSStringFromSelector(_cmd), nil);
    return 1.2;
}

- (BOOL)testPerformSelector1 {
    NSLog(NSStringFromSelector(_cmd), nil);
    return YES;
}

- (void)testPerformSelector2:(id)object0 withObject:(id)object1 withObject:(id)object2 {
    NSLog(NSStringFromSelector(_cmd), nil);
    NSLog(@"0:%@; 1:%@; 2:%@", object0, object1, object2);
}

- (NSString *)testPerformSelector3:(id)object1 withObject:(id)object2 {
    NSLog(NSStringFromSelector(_cmd), nil);
    NSLog(@"0:%@; 1:%@; ", object1, object2);
    return @"阳君";
}

@end
