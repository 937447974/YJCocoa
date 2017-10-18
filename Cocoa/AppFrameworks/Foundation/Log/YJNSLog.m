//
//  YJNSLog.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSLog.h"

#pragma mark -  NSLog打印辅助方法
id logExtension(id obj) {
    id tempObj = obj;
    // 遇到NSArray、NSSet或NSDictionary的子类，内容后移\t
    if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSSet class]]) {
        NSString *str = [NSString stringWithFormat:@"%@", obj];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
        tempObj = str;
    } else if ([obj isKindOfClass:[NSString class]]) { // NSString类型数据加双引号
        tempObj = [NSString stringWithFormat:@"\"%@\"", obj];
    }
    return tempObj;
}

void NSLogS(id obj) {
    NSLog(@"%@", obj);
}


#pragma mark - 数组NSLog打印扩展
@implementation NSArray (YJSLog)

#pragma mark 数组打印
- (NSString *)descriptionWithLocale:(id)locale {
    return [self descriptionWithLocale:locale indent:0];
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *str = [NSMutableString stringWithString:@"[\n"];
    // 遍历数组的所有元素
    for (id obj in self) {
        [str appendFormat:@"\t%@,\n", logExtension(obj)];
    }
    [str appendString:@"]"];
    return str;
}

@end


#pragma mark - 字典NSLog打印扩展
@implementation NSDictionary (YJSLog)

#pragma mark 字典打印
- (NSString *)descriptionWithLocale:(id)locale {
    return [self descriptionWithLocale:locale indent:0];
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    __block NSMutableString *str = [NSMutableString stringWithString:@"{\n"];
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, logExtension(obj)];
    }];
    [str appendString:@"}"];
    // 删掉最后一个,
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    // 保护机制找到才删除
    if (range.location > 0 && range.location < str.length) {
        [str deleteCharactersInRange:range];
    }
    return str;
}

@end


#pragma mark - NSSet NSLog打印扩展
@implementation NSSet (YJSLog)

#pragma mark NSSet打印
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString stringWithString:@"{(\n"];
    for (id value in self) {
        NSLog(@"%@", value);
        [str appendFormat:@"\t%@,\n", logExtension(value)];
    }
    [str appendString:@")}"];
    // 删掉最后一个,
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    // 保护机制找到才删除
    if (range.location > 0 && range.location < str.length) {
        [str deleteCharactersInRange:range];
    }
    return str;
}

@end
