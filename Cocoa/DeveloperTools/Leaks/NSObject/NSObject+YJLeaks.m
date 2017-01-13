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
#import "YJNSSingletonMCenter.h"
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

- (void)leaksCapture {
#if DEBUG
    NSString *className = NSStringFromClass(self.class);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"_"]) {
        return;
    }
    NSLog(@"%@ %@", className, NSStringFromSelector(_cmd));
    NSPointerArray *leakPropertys = [NSPointerArray weakObjectsPointerArray];
    [self leaksCaptureProperty:leakPropertys level:0];
    __weakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSMutableArray *leakPaths = [NSMutableArray array];
        for (NSObject *item in leakPropertys) {
            if (item) {
                [leakPaths addObject:item.leakPropertyPath];
            }
        }
        if (weakSelf || leakPaths.count) {
            NSMutableString *log = [NSMutableString stringWithString:@"\nYJLeaks捕获内存泄漏"];
            if (weakSelf) {
                [log appendFormat:@"\nClass : %@", className];
            }
            if (leakPaths.count) {
                [log appendFormat:@"\nProperty : %@", leakPaths];
            }
            NSLog(@"%@", log);
        }
    });
#endif
}

#pragma mark - private(-)
- (void)leaksCaptureProperty:(NSPointerArray *)leakPropertys level:(NSInteger)level {
    if (level == 3) {
        return;
    }
    level++;
    NSString *className = NSStringFromClass(self.class);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"_"]) {
        return;
    }
    for (NSString *p in [self.class leakPropertys]) {
        id value = [self valueForKey:p];
        if ([value isKindOfClass:[NSObject class]]) {
            NSObject *item = value;
            item.leakPropertyPath = [NSString stringWithFormat:@"%@.%@", self.leakPropertyPath, p];
            [leakPropertys addPointer:(__bridge void * _Nullable)(item)];
            [item leaksCaptureProperty:leakPropertys level:level];
        }
    }
}

#pragma mark - private(+)
+ (NSArray<NSString *> *)leakPropertys {
    Class sourceClass = self.class;
    NSString *className = NSStringFromClass(sourceClass);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"_"]) {
        return [NSMutableArray array];
    }
    NSMutableDictionary *dict = [YJNSSingletonMC registerWeakSingleton:[NSMutableDictionary class] forIdentifier:@"NSObject(YJLeaks)"];
    NSMutableArray<NSString *> *propertys = [dict objectForKey:className];
    if (!propertys) {
        propertys = [NSMutableArray array];
        [dict setObject:propertys forKey:className];
        NSString *leakProperty;
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(sourceClass, &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            leakProperty = [self getLeakProperty:property];
            if (leakProperty) {
                [propertys addObject:leakProperty];
            }
        }
        free(properties);
        [propertys addObjectsFromArray:[sourceClass.superclass leakPropertys]];
    }
    return propertys;
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


