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

@property (nonatomic, strong) NSPointerArray *weakTargets;
@property (nonatomic, strong) NSPointerArray *workTargets;

@end

@implementation YJNSAspectOrientProgramming

- (instancetype)init {
    self = [super init];
    if (self) {
        self.weakTargets = [NSPointerArray weakObjectsPointerArray];
    }
    return self;
}

- (void)addTarget:(id)target {
    [self.weakTargets compact];
    for (id item in self.weakTargets) {
        if ([item isEqual:target]) return;
    }
    [self.weakTargets addPointer:(__bridge void *)target];
    self.workTargets = self.weakTargets.copy;
}

- (void)removeTarget:(id)target {
    [self.weakTargets compact];
    for (NSInteger index = 0; index < self.weakTargets.count; index++) {
        if ([target isEqual:[self.weakTargets pointerAtIndex:index]]) {
            [self.weakTargets removePointerAtIndex:index];
            self.workTargets = self.weakTargets.copy;
            return;
        }
    }
}

#pragma mark - aop
- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) return YES;
    for (id target in self.workTargets) {
        if ([target respondsToSelector:aSelector]) return YES;
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    for (id target in self.workTargets) {
        NSMethodSignature *signature = [target methodSignatureForSelector:selector];
        if (signature) return signature;
    }
    return [YJNSAspectOrientProgramming instanceMethodSignatureForSelector:@selector(unrecognizedSelector)];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    for (id target in self.workTargets) {
        if ([target respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:target];
        }
    }
}

- (void)unrecognizedSelector {}

@end
