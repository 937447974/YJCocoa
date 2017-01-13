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
    NSString *className = NSStringFromClass(self.class);
    if ([className hasPrefix:@"UI"] || [className hasPrefix:@"NS"] || [className hasPrefix:@"_"]) {
        return;
    }
    NSPointerArray *leakPropertys = [NSPointerArray weakObjectsPointerArray];
    [self leaksCaptureProperty:leakPropertys level:0];
    __weakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [leakPropertys compact];
        if (weakSelf || leakPropertys.count) {
            NSMutableString *log = [NSMutableString stringWithString:@"\nYJLeaks捕获内存泄漏"];
            if (weakSelf) {
                [log appendFormat:@"\nclass:%@", className];
            }
            if (leakPropertys.count) {
                NSMutableArray *leakPaths = [NSMutableArray array];
                for (NSObject *item in leakPropertys) {
                    [leakPaths addObject:item.leakPropertyPath];
                }
                [log appendFormat:@"\nproperty:%@", leakPaths];
            }
            NSLog(@"%@", log);
        }
    });
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
        NSObject *item = [self valueForKey:p];
        if (item && [item isKindOfClass:[NSObject class]]) {
            item.leakPropertyPath = [NSString stringWithFormat:@"%@.%@", self.leakPropertyPath, p];
            [leakPropertys addPointer:(__bridge void * _Nullable)(item)];
            [item leaksCaptureProperty:leakPropertys level:level];
        }
    }
}

#pragma mark - private(+)
+ (NSArray<NSString *> *)leakPropertys {
    Class sourceClass = self.class;
    if (sourceClass == [NSObject class]) {
        return [NSMutableArray array];
    }
    NSMutableDictionary *dict = [YJNSSingletonMC registerWeakSingleton:[NSMutableDictionary class] forIdentifier:@"NSObject(YJLeaks)"];
    NSMutableArray<NSString *> *propertys = [dict objectForKey:NSStringFromClass(sourceClass)];
    if (!propertys) {
        propertys = [NSMutableArray array];
        [dict setObject:propertys forKey:NSStringFromClass(self.class)];
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
        [propertys addObjectsFromArray:[[sourceClass superclass] leakPropertys]];
    }
    return propertys;
}

+ (NSString *)getLeakProperty:(objc_property_t)property  {
    NSString *propertyAttributes = [NSString stringWithUTF8String:property_getAttributes(property)];
    NSArray *attributeItems = [propertyAttributes componentsSeparatedByString:@","];
    // R:The property is read-only (readonly);W:The property is a weak;N:NSObject
    if ([attributeItems containsObject:@"R"] || [attributeItems containsObject:@"W"] || ![attributeItems containsObject:@"N"]) {
        return nil;
    }
    if (attributeItems.count == 4) {
        NSScanner *scanner = [NSScanner scannerWithString:propertyAttributes];
        if ([scanner scanString:@"T@\"" intoString:nil]) {
            NSString *attributeClassName;
            [scanner scanUpToString:@"\"," intoString:&attributeClassName];
            if (NSClassFromString(attributeClassName)) {
                return [NSString stringWithUTF8String:property_getName(property)];
            }
        }
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


