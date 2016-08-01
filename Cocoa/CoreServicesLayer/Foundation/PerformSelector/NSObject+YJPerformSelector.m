//
//  NSObject+YJPerformSelector.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "NSObject+YJPerformSelector.h"

@implementation NSObject (YJPerformSelector)

- (YJPerformSelector *)performSelector:(SEL)aSelector withObjects:(NSArray<id> *)objects {
    NSMethodSignature *sig = [self methodSignatureForSelector:aSelector];
    if (sig) {
        NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:aSelector];
        NSInteger idx = 2;
        for (__strong id obj in objects) {
            [invo setArgument:&obj atIndex:idx++];
        }
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return [[YJPerformSelector alloc] initWithSuccess:YES result:anObject];
        } else {
            return [[YJPerformSelector alloc] initWithSuccess:YES result:nil];
        }
    }
    return [[YJPerformSelector alloc] initWithSuccess:NO result:nil];
}

@end
