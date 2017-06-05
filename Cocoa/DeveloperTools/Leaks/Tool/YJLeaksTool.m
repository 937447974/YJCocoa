//
//  YJLeaksTool.m
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/6/5.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "YJLeaksTool.h"
#import <objc/runtime.h>
#import "YJDispatch.h"
#import "YJLeakRetainCount.h"
#import "YJNSFoundationOther.h"

#if DEBUG

@interface NSObject (YJLeaksProperty)

@property (nonatomic, copy) NSString *leakPropertyPath; ///<内存泄漏属性地址

@end

@implementation NSObject (YJLeaksProperty)

- (NSString *)leakPropertyPath {
    NSString *leakPropertyPath = objc_getAssociatedObject(self, "leakPropertyPath");
    if (leakPropertyPath) {
        return leakPropertyPath;
    }
    return YJNSStringFromClass(self.class);
}

- (void)setLeakPropertyPath:(NSString *)leakPropertyPath {
    objc_setAssociatedObject(self, "leakPropertyPath", leakPropertyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@interface YJLeaksTool ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<NSString *> *> *propertys;

@end

@implementation YJLeaksTool

- (instancetype)init {
    self = [super init];
    if (self) {
        _ignoredClasses = [NSMutableSet set];
        self.propertys = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)captureTargetMemoryLeaks:(NSObject *)target {
    NSString *className = YJNSStringFromClass(target.class);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"CA"] || [className hasPrefix:@"_"]) {
        return;
    }
    NSLog(@"%@ capture memory leaks start", className);
    NSPointerArray *leakPropertyArray = [NSPointerArray weakObjectsPointerArray];
    [self captureMemory:(NSObject *)target leakPropertyArray:leakPropertyArray level:0];
    __weak typeof(target) wTarget = target;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSMutableSet *leakPathSet = [NSMutableSet set];
        for (NSObject *item in leakPropertyArray) {
            if (item) {
                [leakPathSet addObject:item.leakPropertyPath];
            }
        }
        if (wTarget || leakPathSet.count) {
            NSMutableString *log = [NSMutableString stringWithString:@"\nYJLeaks捕获内存泄漏"];
            if (wTarget) {
                [log appendFormat:@"\nClass : %@", className];
            }
            if (leakPathSet.count) {
                [log appendFormat:@"\nProperty : %@", leakPathSet];
            }
            NSLog(@"%@", log);
        }
        NSLog(@"%@ capture memory leaks end", className);
    });
}

#pragma mark - private(-)
- (void)captureMemory:(NSObject *)target leakPropertyArray:(NSPointerArray *)leakPropertyArray level:(NSInteger)level {
    if (level == 3) {
        return;
    }
    if ([self.ignoredClasses containsObject:self.class]) { // 对象忽略
        return;
    }
    NSString *className = YJNSStringFromClass(self.class);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"CA"] || [className hasPrefix:@"_"]) {
        return;
    }
    level++;
    for (NSString *p in [self leakProperties:target.class]) {
        id value = [target valueForKey:p];
        if ([value isKindOfClass:[NSObject class]] && ![value isKindOfClass:[NSString class]]) { // 忽略 NSString
            NSObject *item = value;
            item.leakPropertyPath = [NSString stringWithFormat:@"%@.%@", target.leakPropertyPath, p];
            [leakPropertyArray addPointer:(__bridge void * _Nullable)(item)];
            [self captureMemory:item leakPropertyArray:leakPropertyArray level:level];
        }
    }
}

#pragma mark - private(+)
- (NSArray<NSString *> *)leakProperties:(Class)targetClass {
    NSString *className = YJNSStringFromClass(targetClass);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"CA"] || [className hasPrefix:@"_"]) {
        return [NSMutableArray array];
    }
    NSMutableDictionary *dict = YJNSSingletonW(NSMutableDictionary, @"NSObject(YJLeaks)");
    NSMutableArray<NSString *> *propertyArray = [dict objectForKey:className];
    if (!propertyArray) {
        propertyArray = [NSMutableArray array];
        [dict setObject:propertyArray forKey:className];
        NSString *propertyAttributes;
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(targetClass, &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
            // &:The property is a reference to the value last assigned (retain).
            if ([propertyAttributes hasPrefix:@"T@"] && [propertyAttributes rangeOfString:@",&,"].location != NSNotFound) {
                [propertyArray addObject:[NSString stringWithUTF8String:property_getName(property)]];
            }
        }
        free(properties);
        [propertyArray addObjectsFromArray:[self leakProperties:targetClass.superclass]];
    }
    return propertyArray;
}

@end

#endif


