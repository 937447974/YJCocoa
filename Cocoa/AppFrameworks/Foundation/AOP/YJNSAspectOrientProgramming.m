//
//  YJNSAspectOrientProgramming.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/14.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSAspectOrientProgramming.h"

@interface YJNSAspectOrientProgramming ()

@property (nonatomic, strong) NSPointerArray *weakTargets; ///< 目标集合

@end

@implementation YJNSAspectOrientProgramming

- (instancetype)init {
    self = [super init];
    if (self) {
        self.weakTargets = [NSPointerArray weakObjectsPointerArray];
    }
    return self;
}

- (void)addTarget:(NSObject *)target {
    [self.weakTargets compact];
    for (id item in self.weakTargets) {
        if ([item isEqual:target]) {
            return;
        }
    }
    [self.weakTargets addPointer:(__bridge void * _Nullable)(target)];
}

- (void)removeTarget:(NSObject *)target {
    [self.weakTargets compact];
    for (NSInteger index = 0; index < self.weakTargets.count; index++) {
        if ([target isEqual:[self.weakTargets pointerAtIndex:index]]) {
            [self.weakTargets removePointerAtIndex:index];
            return;
        }
    }
}

#pragma mark - aop
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    } else {
        for (id target in self.weakTargets) {
            if ([target respondsToSelector:aSelector]) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        for (id target in self.weakTargets) {
            signature = [target methodSignatureForSelector:selector];
            if (signature) {
                break;
            }
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    for (id target in self.weakTargets) {
        if ([target respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:target];
        }
    }
}

@end
