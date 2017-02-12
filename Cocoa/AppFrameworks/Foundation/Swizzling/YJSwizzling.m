//
//  YJSwizzling.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/12.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJSwizzling.h"
#import <objc/runtime.h>
#import "YJDispatch.h"
#import "YJNSSingletonMCenter.h"

@implementation NSObject (YJSwizzling)

+ (void)swizzlingClassSEL:(SEL)originalSEL withSEL:(SEL)swizzlingSEL {
    [object_getClass(self) swizzlingSEL:originalSEL withSEL:swizzlingSEL];
}

+ (void)swizzlingSEL:(SEL)originalSEL withSEL:(SEL)swizzlingSEL {
    dispatch_sync_main(^{
        Class class = self.class;
        // cache
        NSMutableDictionary *selCache = [YJNSSingletonMC registerStrongSingleton:[NSMutableDictionary class] forIdentifier:@"YJSwizzling"];
        NSString *key = [NSString stringWithFormat:@"%@-%@-%@", NSStringFromClass(class), NSStringFromSelector(originalSEL), NSStringFromSelector(swizzlingSEL)];
        if ([selCache objectForKey:key]) {
            return;
        }
        [selCache setObject:@"YJSwizzling" forKey:key];
        [selCache removeObjectForKey:[NSString stringWithFormat:@"%@-%@-%@", NSStringFromSelector(swizzlingSEL), NSStringFromClass(class), NSStringFromSelector(originalSEL)]];
        NSLog(@"%@ %@(%@ <-> %@)", NSStringFromClass(class), NSStringFromSelector(_cmd), NSStringFromSelector(originalSEL), NSStringFromSelector(swizzlingSEL));
        // swizzling
        Method originalMethod = class_getInstanceMethod(class, originalSEL);
        Method swizzlingMethod = class_getInstanceMethod(class, swizzlingSEL);
        BOOL addMethod = class_addMethod(class, originalSEL, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
        if (addMethod) {
            class_replaceMethod(class, swizzlingSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzlingMethod);
        }
    });
}

@end
