//
//  NSObject+YJLeaks.m
//  YJLeaks
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/13.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import "NSObject+YJLeaks.h"
#import <objc/runtime.h>
#import "YJNSSingleton.h"
#import "YJDispatch.h"

@interface NSObject (YJLeaksProperty)

@property (nonatomic, copy) NSString *leakPropertyPath; ///<内存泄漏属性地址

@end

#pragma mark -
#pragma mark - YJLeaks
@implementation NSObject (YJLeaks)

+ (void)start {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)captureMemoryLeaks {
#if DEBUG
    NSString *className = NSStringFromClass(self.class);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"_"]) {
        return;
    }
    NSLog(@"%@ capture memory leaks start", className);
    NSPointerArray *leakPropertyArray = [NSPointerArray weakObjectsPointerArray];
    [self captureMemoryLeakPropertyArray:leakPropertyArray level:0];
    @weakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        @strongSelf
        NSMutableSet *leakPathSet = [NSMutableSet set];
        for (NSObject *item in leakPropertyArray) {
            if (item) {
                [leakPathSet addObject:item.leakPropertyPath];
            }
        }
        if (self || leakPathSet.count) {
            NSMutableString *log = [NSMutableString stringWithString:@"\nYJLeaks捕获内存泄漏"];
            if (self) {
                [log appendFormat:@"\nClass : %@", className];
            }
            if (leakPathSet.count) {
                [log appendFormat:@"\nProperty : %@", leakPathSet];
            }
            NSLog(@"%@", log);
        }
        NSLog(@"%@ capture memory leaks end", className);
    });
#endif
}

#pragma mark - private(-)
- (void)captureMemoryLeakPropertyArray:(NSPointerArray *)leakPropertyArray level:(NSInteger)level {
    if (level == 3) {
        return;
    }
    level++;
    NSString *className = NSStringFromClass(self.class);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"_"]) {
        return;
    }
    for (NSString *p in [self.class leakProperties]) {
        id value = [self valueForKey:p];
        if ([value isKindOfClass:[NSObject class]]) {
            NSObject *item = value;
            item.leakPropertyPath = [NSString stringWithFormat:@"%@.%@", self.leakPropertyPath, p];
            [leakPropertyArray addPointer:(__bridge void * _Nullable)(item)];
            [item captureMemoryLeakPropertyArray:leakPropertyArray level:level];
        }
    }
}

#pragma mark - private(+)
+ (NSArray<NSString *> *)leakProperties {
    Class sourceClass = self.class;
    NSString *className = NSStringFromClass(sourceClass);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"_"]) {
        return [NSMutableArray array];
    }
    NSMutableDictionary *dict = YJNSSingletonW(NSMutableDictionary, @"NSObject(YJLeaks)");
    NSMutableArray<NSString *> *propertyArray = [dict objectForKey:className];
    if (!propertyArray) {
        propertyArray = [NSMutableArray array];
        [dict setObject:propertyArray forKey:className];
        NSString *leakProperty;
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(sourceClass, &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            leakProperty = [self getLeakProperty:property];
            if (leakProperty) {
                [propertyArray addObject:leakProperty];
            }
        }
        free(properties);
        [propertyArray addObjectsFromArray:[sourceClass.superclass leakProperties]];
    }
    return propertyArray;
}

+ (NSString *)getLeakProperty:(objc_property_t)property  {
    NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    // &:The property is a reference to the value last assigned (retain).
    if ([propertyAttributes hasPrefix:@"T@"] && [propertyAttributes rangeOfString:@",&,"].location != NSNotFound) {
        return [NSString stringWithUTF8String:property_getName(property)];
    }
    return nil;
}

@end

#pragma mark -
#pragma mark - YJLeaksProperty
@implementation NSObject (YJLeaksProperty)

- (NSString *)leakPropertyPath {
    NSString *leakPropertyPath = objc_getAssociatedObject(self, "leakPropertyPath");
    if (leakPropertyPath) {
        return leakPropertyPath;
    }
    return NSStringFromClass(self.class);
}

- (void)setLeakPropertyPath:(NSString *)leakPropertyPath {
    objc_setAssociatedObject(self, "leakPropertyPath", leakPropertyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end


