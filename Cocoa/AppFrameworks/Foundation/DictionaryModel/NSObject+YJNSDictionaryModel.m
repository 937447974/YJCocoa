//
//  NSObject+YJNSDictionaryModel.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/9/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "NSObject+YJNSDictionaryModel.h"
#import "YJNSDictionaryModelProperty.h"
#import "YJNSSingleton.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (YJNSDictionaryModel)

#pragma mark public(+)
+ (YJNSDictionaryModelManager *)dictionaryModelManager {
    return YJNSDictionaryModelManager.new;
}

#pragma mark - init
- (instancetype)initWithModelDictionary:(NSDictionary *)modelDictionary {
    if ([NSStringFromClass(self.class) hasPrefix:@"__NS"]) return modelDictionary;
    return [self initWithModelDictionary:modelDictionary optionalAttributes:@{}];
}

- (instancetype)initWithModelDictionary:(NSDictionary *)modelDictionary optionalAttributes:(NSDictionary<NSString *,NSString *> *)optionalAttributes {
    self = [self init];
    if (self) {
        [self setModelDictionary:modelDictionary optionalAttributes:optionalAttributes];
    }
    return self;
}

#pragma mark - geter & setter
- (NSDictionary *)modelDictionary {
    if ([NSStringFromClass(self.class) hasPrefix:@"__NS"]) return (NSDictionary *)self;
    return [self modelDictionaryWithOptionalAttributes:@{}];
}

- (NSDictionary *)modelDictionaryWithOptionalAttributes:(NSDictionary<NSString *,NSString *> *)optionalAttributes {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (YJNSDictionaryModelProperty *p in self.class.propertys) {
        id value = [self valueForKey:p.attributeName];
        switch (p.attributeType) {
            case YJNSDMPAttributeTypeNumber:     // NSNumber
            case YJNSDMPAttributeTypeString:     // NSString
            case YJNSDMPAttributeTypeDictionary: // NSDictionary
            case YJNSDMPAttributeTypeSet:        // NSSet
                break;
            case YJNSDMPAttributeTypeURL:        // NSURL
                if (value) {
                    NSURL *url = value;
                    value = url.fileURL ? url.path : url.absoluteString;
                } break;
            case YJNSDMPAttributeTypeArray:      // NSArray
                if (value && !p.importArrayClassSystem) {
                    value = [self getDictionaryArrayValue:value forProperty:p];
                } break;
            case YJNSDMPAttributeTypeModel:      // Model
                value = ((NSObject *)value).modelDictionary;
                break;
        }
        if (value) {
            NSString *attributeKey = [optionalAttributes objectForKey:p.attributeName];
            [dict setObject:value forKey:attributeKey ?: p.attributeKey];
        }
    }
    return dict;
}

- (void)setModelDictionary:(NSDictionary *)modelDictionary optionalAttributes:(NSDictionary<NSString *,NSString *> *)optionalAttributes {
    if (![modelDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    for (YJNSDictionaryModelProperty *p in self.class.propertys) {
        NSString *attributeKey = [optionalAttributes objectForKey:p.attributeName];
        id value = [modelDictionary objectForKey:attributeKey ?: p.attributeKey];
        if (!value || [value isKindOfClass:NSNull.class]) continue;
        switch (p.attributeType) {
            case YJNSDMPAttributeTypeNumber:
                if ([value isKindOfClass:NSString.class]) {
                    value = [numberFormatter numberFromString:value];
                }
                if (![value isKindOfClass:NSNumber.class]) value = nil;
                break;
            case YJNSDMPAttributeTypeString:
                value = [NSString stringWithFormat:@"%@", value];
                break;
            case YJNSDMPAttributeTypeURL:
                if ([value isKindOfClass:NSString.class]) {
                    value = [value hasPrefix:@"http"] ? [NSURL URLWithString:value] : [NSURL fileURLWithPath:value];
                }
                if (![value isKindOfClass:NSURL.class]) value = nil;
                break;
            case YJNSDMPAttributeTypeArray:
                if ([value isKindOfClass:NSArray.class]) {
                    if (!p.importArrayClassSystem)
                        value = [self getModelArrayValue:value forProperty:p];
                } else value = nil;
                break;
            case YJNSDMPAttributeTypeDictionary:
                if (![value isKindOfClass:NSDictionary.class]) value = nil;
                break;
            case YJNSDMPAttributeTypeSet:
                if (![value isKindOfClass:NSSet.class]) value = nil;
                break;
            case YJNSDMPAttributeTypeModel:
                value = [[p.attributeClass alloc] initWithModelDictionary:value];
                break;
        }
        if (value) [self setValue:value forKey:p.attributeName];
    }
}

#pragma mark - private(-)
- (NSMutableArray *)getDictionaryArrayValue:(NSArray *)array forProperty:(YJNSDictionaryModelProperty *)p {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    for (id value in array) {
        if ([value isKindOfClass:[NSArray class]]) {
            [result addObject:[self getDictionaryArrayValue:value forProperty:p]];
        } else if ([value isKindOfClass:p.importArrayClass]) {
            [result addObject:((NSObject *)value).modelDictionary];
        } else {
            [result addObject:value];
        }
    }
    return result;
}

- (NSMutableArray *)getModelArrayValue:(NSArray *)array forProperty:(YJNSDictionaryModelProperty *)p {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    for (id value in array) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            [result addObject:[[p.importArrayClass alloc] initWithModelDictionary:value]];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [result addObject:[self getModelArrayValue:value forProperty:p]];
        } else {
            [result addObject:value];
        }
    }
    return result;
}

#pragma mark - private(+)
+ (NSArray<YJNSDictionaryModelProperty *> *)propertys {
    Class cls = self.class;
    NSString *key = NSStringFromClass(cls);
    if (cls == NSObject.class || [key hasPrefix:@"__NS"]) return NSArray.array;
    NSCache *cache = YJNSSingletonS(NSCache, @"NSObject(YJNSDictionaryModel)");
    NSArray *propertys = [cache objectForKey:key];
    if (!propertys) {
        NSMutableArray *propertysMutable = cls.superclass.propertys.mutableCopy;
        YJNSDictionaryModelManager *dMManager = cls.dictionaryModelManager;
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(cls, &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            YJNSDictionaryModelProperty *p = [cls getModelProperty:property dictionaryModelManager:dMManager];
            if (p) [propertysMutable addObject:p];
        }
        free(properties);
        propertys = propertysMutable.copy;
        [cache setObject:propertys forKey:key];
    }
    return propertys;
}

+ (YJNSDictionaryModelProperty *)getModelProperty:(objc_property_t)property dictionaryModelManager:(YJNSDictionaryModelManager *)dMManager {
    YJNSDictionaryModelProperty *p = [[YJNSDictionaryModelProperty alloc] init];
    // 属性名
    const char *propertyName = property_getName(property);
    p.attributeName = @(propertyName);
    if ([dMManager.ignoredAttributes containsObject:p.attributeName]) return nil;
    p.attributeKey = [dMManager.optionalAttributes objectForKey:p.attributeName];
    p.attributeKey = p.attributeKey ? p.attributeKey : p.attributeName;
    // 属性参数
    const char *attrs = property_getAttributes(property);
    NSString *propertyAttributes = @(attrs);
    NSArray *attributeItems = [propertyAttributes componentsSeparatedByString:@","];
    // R:The property is read-only (readonly);W:The property is a weak;N:NSObject
    if ([attributeItems containsObject:@"R"] || [attributeItems containsObject:@"W"] || ![attributeItems containsObject:@"N"]) return nil;
    // immutable classes: NSNumber, NSString, NSURL, NSArray, NSDictionary
    NSScanner *scanner = [NSScanner scannerWithString:propertyAttributes];
    if ([scanner scanString:@"T@\"" intoString:nil]) {
        if (attributeItems.count == 4) {
            NSString *attributeClassName;
            [scanner scanUpToString:@"\"," intoString:&attributeClassName];
            p.attributeClass = NSClassFromString(attributeClassName);
            if (!p.attributeClass) {
                NSLog(@"YJNSDictionaryModel ⚠️ 属性%@对应的类%@不存在", p.attributeName , attributeClassName);
                return nil;
            }
            if ([dMManager.systemBaseClass containsObject:p.attributeClass]) {
                if ([p.attributeClass isSubclassOfClass:[NSString class]]) {
                    p.attributeType = YJNSDMPAttributeTypeString;
                } else if ([p.attributeClass isSubclassOfClass:[NSURL class]]) {
                    p.attributeType = YJNSDMPAttributeTypeURL;
                } else if ([p.attributeClass isSubclassOfClass:[NSDictionary class]]) {
                    p.attributeType = YJNSDMPAttributeTypeDictionary;
                } else if ([p.attributeClass isSubclassOfClass:NSSet.class]) {
                    p.attributeType = YJNSDMPAttributeTypeSet;
                } else if ([p.attributeClass isSubclassOfClass:[NSArray class]]) {
                    p.attributeType = YJNSDMPAttributeTypeArray;
                    p.importArrayClass = [dMManager.importArrayClasses objectForKey:p.attributeName];
                    if (p.importArrayClass) {
                        p.importArrayClassSystem = [dMManager.systemBaseClass containsObject:p.importArrayClass];
                    }
                }
            } else {
                p.attributeType = YJNSDMPAttributeTypeModel;
            }
        } else {
            NSLog(@"YJNSDictionaryModel jump parse class:%@; attributeName:%@, propertyAttributes:%@", self, p.attributeName, propertyAttributes);
            return nil;
        }
    } else if (attributeItems.count == 3) {
        p.attributeType = YJNSDMPAttributeTypeNumber;
    } else {
        NSLog(@"YJNSDictionaryModel ⚠️ class:%@; propertyAttributes:%@", self, propertyAttributes);
        return nil;
    }
    return p;
}

@end
