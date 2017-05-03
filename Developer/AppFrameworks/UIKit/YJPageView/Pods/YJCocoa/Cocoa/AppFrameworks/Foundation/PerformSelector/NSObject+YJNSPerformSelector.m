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

- (id)performSelector:(SEL)aSelector withObjects:(NSArray<id> *)objects {
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
            // https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
            NSSet *numberSet = [NSSet setWithObjects:@"c", @"i", @"s", @"l", @"q", @"C", @"I", @"S", @"L", @"Q", @"f", @"d", @"B", nil];
            NSString *type = [NSString stringWithUTF8String:sig.methodReturnType];
            if ([numberSet containsObject:type]) {
                void *value;
                [invo getReturnValue:&value];
                anObject = [[NSNumber alloc] initWithBytes:&value objCType:sig.methodReturnType];
            } else {
                [invo getReturnValue:&anObject];
            }
        }
    }
    return anObject;
}

@end
