//
//  YJAOPTest.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/14.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJFoundation.h"

@interface YJTest1 : NSObject

@end

@implementation YJTest1

- (void)test1 {
    NSLogS(NSStringFromSelector(_cmd));
    NSLogS(self);
}

- (void)test3 {
    NSLogS(NSStringFromSelector(_cmd));
    NSLogS(self);
}

@end

@interface YJTest2 : NSObject

@end

@implementation YJTest2

- (void)test2 {
    NSLogS(NSStringFromSelector(_cmd));
    NSLogS(self);
}

- (void)test3 {
    NSLogS(NSStringFromSelector(_cmd));
    NSLogS(self);
}

@end

@interface YJAOPTest : XCTestCase

@end

@implementation YJAOPTest

- (void)testExample {
    YJNSAspectOrientProgramming *aop = [YJNSAspectOrientProgramming new];
    YJTest1 *test1 = [YJTest1 new];
    YJTest2 *test2 = [YJTest2 new];
    [aop addTarget:test1];
    [aop addTarget:test2];
    [aop performSelector:@selector(test1)];
    [aop performSelector:@selector(test2)];
    [aop performSelector:@selector(test3)];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Undeclared-Selector"
    //写在这个中间的代码,都不会被编译器提示-Wdeprecated-declarations类型的警告
//    dispatch_queue_tcurrent Queue =dispatch_get_current_queue();
    [aop performSelector:@selector(test4) withObjects:nil];
#pragma clang diagnostic pop
    
}


@end
