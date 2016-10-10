//
//  YJNSHttpAnalysis.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSHttpAnalysis.h"

@implementation YJNSHttpAnalysis

+ (NSDictionary<NSString *,NSString *> *)analysisParams:(NSString *)http {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSRange start = [http rangeOfString:@"?"];
    if (start.location != NSNotFound) {
        http = [http substringFromIndex:start.location+1];
    }
    NSArray *array = [http componentsSeparatedByString:@"&"]; // 获取单一参数
    NSArray *keyValue;
    NSString *param, *value;
    for (param in array) {
        keyValue = [param componentsSeparatedByString:@"="]; // 参数分离
        value = keyValue.count == 2 ? keyValue.lastObject : @"";
        [dict setObject:value forKey:keyValue.firstObject];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (NSString *)analysisParams:(NSString *)http forKey:(NSString *)key {
    return [[self analysisParams:http] objectForKey:key];
}

@end
