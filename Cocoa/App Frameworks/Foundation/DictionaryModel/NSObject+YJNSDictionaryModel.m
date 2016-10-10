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
#import "YJNSSingletonMCenter.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (YJNSDictionaryModel)

#pragma mark public(+)
+ (YJNSDictionaryModelManager *)dictionaryModelManager {
    return [[YJNSDictionaryModelManager alloc] init];
}

#pragma mark - init
- (instancetype)initWithModelDictionary:(NSDictionary *)modelDictionary {
    self = [self init];
    if (self) {
        [self setModelDictionary:modelDictionary];
    }    
    return self;
}

#pragma mark - geter & setter
- (NSDictionary *)modelDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *propertys = [self.class propertys];
    for (YJNSDictionaryModelProperty *p in propertys) {
        id value;
        switch (p.attributeType) {
            case YJNSDMPAttributeTypeNumber:     // NSNumber
            case YJNSDMPAttributeTypeString:     // NSString
            case YJNSDMPAttributeTypeDictionary: // NSDictionary
                value = [self valueForKey:p.attributeName];
                break;
            case YJNSDMPAttributeTypeArray:      // NSArray
                value = [self valueForKey:p.attributeName];
                if (value && !p.importArrayClassSystem) {
                    value = [self getDictionaryArrayValue:value forProperty:p];
                }
                break;
            case YJNSDMPAttributeTypeModel:      // Model
                value = ((NSObject *)[self valueForKey:p.attributeName]).modelDictionary;
                break;
        }
        if (value) {
            [dict setObject:value forKey:p.attributeKey];
        }
    }
    return dict;
}

- (void)setModelDictionary:(NSDictionary * _Nonnull)modelDictionary {
    if (![modelDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSArray *propertys = [self.class propertys];
    for (YJNSDictionaryModelProperty *p in propertys) {
        id value = [modelDictionary objectForKey:p.attributeKey];
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            continue;
        }
        switch (p.attributeType) {
            case YJNSDMPAttributeTypeNumber:     // NSNumber
                [self setValue:value forKey:p.attributeName];
                break;
            case YJNSDMPAttributeTypeString:     // NSString
                [self setValue:[NSString stringWithFormat:@"%@", value] forKey:p.attributeName];
                break;
            case YJNSDMPAttributeTypeArray:      // NSArray
                if ([value isKindOfClass:[NSArray class]]) {
                    if (!p.importArrayClassSystem) {
                        value = [self getModelArrayValue:value forProperty:p];
                    }
                    [self setValue:value forKey:p.attributeName];
                }
                break;
            case YJNSDMPAttributeTypeDictionary: // NSDictionary
                if ([value isKindOfClass:[NSDictionary class]]) {
                    [self setValue:value forKey:p.attributeName];
                }
                break;
            case YJNSDMPAttributeTypeModel:      // Model
                if ([value isKindOfClass:[NSDictionary class]]) {
                    value = [[p.attributeClass alloc] initWithModelDictionary:value];
                    [self setValue:value forKey:p.attributeName];
                }
                break;
        }
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
    Class sourceClass = self.class;
    if (sourceClass == [NSObject class]) {
        return [NSMutableArray array];
    }
    NSMutableDictionary *dict = [YJNSSingletonMC registerWeakSingleton:[NSMutableDictionary class] forIdentifier:@"NSObject(YJNSDictionaryModel)"];
    NSMutableArray<YJNSDictionaryModelProperty *> *propertys = [dict objectForKey:NSStringFromClass(sourceClass)];
    if (!propertys) {
        propertys = [NSMutableArray array];
        [dict setObject:propertys forKey:NSStringFromClass(self.class)];
        YJNSDictionaryModelManager *dMManager = [sourceClass dictionaryModelManager];
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(sourceClass, &propertyCount);
        for (unsigned int i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            YJNSDictionaryModelProperty *p = [self getModelProperty:property dictionaryModelManager:dMManager];
            if (p) {
                [propertys addObject:p];
            }
        }
        free(properties);
        [propertys addObjectsFromArray:[[sourceClass superclass] propertys]];
    }
    return propertys;
}

+ (YJNSDictionaryModelProperty *)getModelProperty:(objc_property_t)property dictionaryModelManager:(YJNSDictionaryModelManager *)dMManager {
    YJNSDictionaryModelProperty *p = [[YJNSDictionaryModelProperty alloc] init];
    // 属性名
    const char *propertyName = property_getName(property);
    p.attributeName = @(propertyName);
    if ([dMManager.ignoredAttributes containsObject:p.attributeName]) {
        return nil;
    }
    p.attributeKey = [dMManager.optionalAttributes objectForKey:p.attributeName];
    p.attributeKey = p.attributeKey ? p.attributeKey : p.attributeName;
    // 属性参数
    const char *attrs = property_getAttributes(property);
    NSString *propertyAttributes = @(attrs);
    NSArray *attributeItems = [propertyAttributes componentsSeparatedByString:@","];
    // R:The property is read-only (readonly);W:The property is a weak;N:NSObject
    if ([attributeItems containsObject:@"R"] || [attributeItems containsObject:@"W"] || ![attributeItems containsObject:@"N"]) {
        return nil;
    }
    // immutable classes: NSString, NSNumber, NSArray, NSDictionary
    if (attributeItems.count == 3) {
        p.attributeClass = YJNSDMPAttributeTypeNumber;
    } else if (attributeItems.count == 4) {
        NSScanner *scanner = [NSScanner scannerWithString:propertyAttributes];
        if ([scanner scanString:@"T@\"" intoString:nil]) {
            NSString *attributeClassName;
            [scanner scanUpToString:@"\"," intoString:&attributeClassName];
            p.attributeClass = NSClassFromString(attributeClassName);
            if (!p.attributeClass) {
                NSLog(@"属性%@对应的类%@不存在", p.attributeName , attributeClassName);
                return nil;
            }
            if ([dMManager.systemBaseClass containsObject:p.attributeClass]) {
                if ([p.attributeClass isSubclassOfClass:[NSString class]]) {
                    p.attributeType = YJNSDMPAttributeTypeString;
                } else if ([p.attributeClass isSubclassOfClass:[NSDictionary class]]) {
                    p.attributeType = YJNSDMPAttributeTypeDictionary;
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
            return nil;
        }
    } else {
        NSLog(@"请通知阳君，QQ:937447974修复BUG");
        return nil;
    }
    return p;
}

@end
