//
//  NSObject+YJSDictionaryModel.m
//  YJSFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/9/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "NSObject+YJSDictionaryModel.h"
#import "YJSDictionaryModelProperty.h"
#import "YJSSingletonMCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (YJSDictionaryModel)

#pragma mark public +
+ (NSString *)getDictKeyWithAttributeName:(NSString *)attributeName {
    return attributeName;
}

+ (Class)getImportArrayClassWithAttributeName:(NSString *)attributeName {
    return [NSString class];
}

+ (NSSet<NSString *> *)ignoredAttributes {
    return [[NSSet alloc] init];
}

#pragma mark -
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [self init];
    if (!self) {
        return self;
    }
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return self;
    }
    NSArray *propertys = [self propertys];
    for (YJSDictionaryModelProperty *p in propertys) {
        id value = [dict objectForKey:p.attributeKey];
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            continue;
        }
        switch (p.attributeType) {
            case YJSDMPAttributeTypeNumber:     // NSNumber
                [self setValue:value forKey:p.attributeName];
                break;
            case YJSDMPAttributeTypeString:     // NSString
                [self setValue:[NSString stringWithFormat:@"%@", value] forKey:p.attributeName];
                break;
            case YJSDMPAttributeTypeArray:      // NSArray
                if ([value isKindOfClass:[NSArray class]]) {
                    if (!p.importArrayClassSystem) {
                        value = [self getArrayValue:value forProperty:p];
                    }
                    [self setValue:value forKey:p.attributeName];
                }
                break;
            case YJSDMPAttributeTypeDictionary: // NSDictionary
                if ([value isKindOfClass:[NSDictionary class]]) {
                    [self setValue:value forKey:p.attributeName];
                }
                break;
            case YJSDMPAttributeTypeModel:      // Model
                if ([value isKindOfClass:[NSDictionary class]]) {
                    value = [[p.attributeClass alloc] initWithDictionary:value];
                    [self setValue:value forKey:p.attributeName];
                }
                break;
        }
    }
    return self;
}

#pragma mark private(-)
- (NSMutableArray *)getArrayValue:(NSArray *)array forProperty:(YJSDictionaryModelProperty *)p {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    for (id value in array) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            [result addObject:[[p.attributeClass alloc] initWithDictionary:value]];
        } else if ([value isKindOfClass:[NSArray class]]) {
            [result addObject:[self getArrayValue:value forProperty:p]];
        } else {
            [result addObject:value];
        }
    }
    return result;
}

- (NSArray<YJSDictionaryModelProperty *> *)propertys {
    NSMutableDictionary *dict = [YJSSingletonMC registerStrongSingleton:[NSMutableDictionary class] forIdentifier:@"NSObject(YJSDictionaryModel)"];
    NSMutableArray<YJSDictionaryModelProperty *> *propertys = [dict objectForKey:NSStringFromClass(self.class)];
    if (!propertys) {
        propertys = [NSMutableArray array];
        [dict setObject:propertys forKey:NSStringFromClass(self.class)];
        NSSet<Class> *systemBaseClass = [NSSet setWithObjects:[NSString class], [NSNumber class], [NSDecimalNumber class], [NSArray class], [NSDictionary class], [NSNull class], [NSMutableString class], [NSMutableArray class], [NSMutableDictionary class], nil];
        Class sourceClass = [self class];
        while (sourceClass != [NSObject class]) {
            unsigned int propertyCount;
            objc_property_t *properties = class_copyPropertyList(sourceClass, &propertyCount);
            NSSet<NSString *> *ignoredAttributes = [sourceClass ignoredAttributes];
            for (unsigned int i = 0; i < propertyCount; i++) {
                objc_property_t property = properties[i];
                YJSDictionaryModelProperty *p = [self getModelPropertyWithClass:sourceClass property:property ignoredAttributes:ignoredAttributes systemBaseClass:systemBaseClass];
                [propertys addObject:p];
            }
            free(properties);
            sourceClass = [sourceClass superclass];
        }
    }
    return propertys;
}

- (YJSDictionaryModelProperty *)getModelPropertyWithClass:(Class)sourceClass property:(objc_property_t)property ignoredAttributes:(NSSet<NSString *> *)ignoredAttributes systemBaseClass:(NSSet<Class> *)systemBaseClass{
    YJSDictionaryModelProperty *p = [[YJSDictionaryModelProperty alloc] init];
    // 属性名
    const char *propertyName = property_getName(property);
    p.attributeName = @(propertyName);
    if ([ignoredAttributes containsObject:p.attributeName]) {
        return nil;
    }
    p.attributeKey = [self.class getDictKeyWithAttributeName:p.attributeName];
    // 属性参数
    const char *attrs = property_getAttributes(property);
    NSString *propertyAttributes = @(attrs);
    NSArray *attributeItems = [propertyAttributes componentsSeparatedByString:@","];
    // R:The property is read-only (readonly);W:The property is a weak;N:NSObject
    if ([attributeItems containsObject:@"R"] || [attributeItems containsObject:@"W"] || [attributeItems containsObject:@"N"]) {
        return nil;
    }
    // immutable classes: NSString, NSNumber, NSArray, NSDictionary
    if (attributeItems.count == 3) {
        p.attributeClass = YJSDMPAttributeTypeNumber;
    } else if (attributeItems.count == 4) {
        NSScanner *scanner = nil;
        if ([scanner scanString:@"T@\"" intoString:nil]) {
            NSString *attributeClassName;
            [scanner scanUpToString:@"\"," intoString:&attributeClassName];
            p.attributeClass = NSClassFromString(attributeClassName);
            if (!p.attributeClass) {
                NSLog(@"%@中属性%@对应的类%@不存在", NSStringFromClass(sourceClass), p.attributeName , attributeClassName);
                return nil;
            }
            if ([systemBaseClass containsObject:p.attributeClass]) {
                if ([p.attributeClass isSubclassOfClass:[NSString class]]) {
                    p.attributeType = YJSDMPAttributeTypeString;
                } else if ([p.attributeClass isSubclassOfClass:[NSDictionary class]]) {
                    p.attributeType = YJSDMPAttributeTypeDictionary;
                } else if ([p.attributeClass isSubclassOfClass:[NSArray class]]) {
                    p.attributeType = YJSDMPAttributeTypeArray;
                    p.attributeClass = [sourceClass getImportArrayClassWithAttributeName:p.attributeName];
                }
            } else {
                p.attributeType = YJSDMPAttributeTypeModel;
            }
        } else {
            NSLog(@"请通知阳君，QQ:937447974修复BUG");
            return nil;
        }
    } else {
        NSLog(@"请通知阳君，QQ:937447974修复BUG");
        return nil;
    }
    return p;
}

@end
