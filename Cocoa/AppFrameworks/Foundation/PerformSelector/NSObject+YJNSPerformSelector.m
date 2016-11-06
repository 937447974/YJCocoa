//
//  NSObject+YJNSPerformSelector.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "NSObject+YJNSPerformSelector.h"

@implementation NSObject (YJNSPerformSelector)

- (YJNSPerformSelector *)performSelector:(SEL)aSelector withObjects:(NSArray<id> *)objects {
    NSMethodSignature *sig = [self methodSignatureForSelector:aSelector];
    id anObject;
    if (sig) {
        NSInvocation *invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:aSelector];
        NSInteger idx = 2;
        for (__strong id obj in objects) {
            if (idx == invo.methodSignature.numberOfArguments) {
                break;
            }
            [invo setArgument:&obj atIndex:idx++];
        }
        [invo invoke];
        if (sig.methodReturnLength) {
            [invo getReturnValue:&anObject];
        }
    }
    return [[YJNSPerformSelector alloc] initWithSuccess:sig result:anObject];
}

@end
