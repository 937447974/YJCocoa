//
//  YJAOPTest.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/14.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJFoundation.h"

@protocol YJTestProtocol <NSObject>

@optional
- (void)test1;
- (void)test2;
- (void)test3;
- (id)test4;

@end

@interface YJTest1 : NSObject <YJTestProtocol>

@end

@implementation YJTest1

- (void)test1 {
    NSLog(@"%@--%@", self, NSStringFromSelector(_cmd));
}

- (void)test3 {
    NSLog(@"%@--%@", self, NSStringFromSelector(_cmd));
}

@end

@interface YJTest2 : NSObject <YJTestProtocol>

@end

@implementation YJTest2

- (void)test2 {
    NSLog(@"%@--%@", self, NSStringFromSelector(_cmd));
    
}

- (void)test3 {
    NSLog(@"%@--%@", self, NSStringFromSelector(_cmd));
}

@end

@interface YJAOPTest : XCTestCase

@end

@implementation YJAOPTest

- (void)testExample {
    YJTest1 *test1 = [YJTest1 new];
    YJTest2 *test2 = [YJTest2 new];
    
    YJNSAspectOrientProgramming *aop = [YJNSAspectOrientProgramming new];
    [aop addTarget:test1];
    [aop addTarget:test2];
    
    id<YJTestProtocol> test = (id<YJTestProtocol>)aop;
    [test test1];
    [test test2];
    [test test3];
    id result = [test test4];
    NSLog(@"%@", result);
}


@end
