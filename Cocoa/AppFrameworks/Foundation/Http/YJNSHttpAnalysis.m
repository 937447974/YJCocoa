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
#import "YJNSURLCode.h"

@implementation YJNSHttpAnalysis

+ (NSDictionary<NSString *,NSString *> *)analysisParams:(NSString *)http URLEncode:(BOOL)encode {
    NSRange range = [http rangeOfString:@"?"];
    if (range.location != NSNotFound) {
        http = [http substringFromIndex:range.location+1];
    }
    range = [http rangeOfString:@"#"];
    if (range.location != NSNotFound) {
        http = [http substringToIndex:range.location];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *array = [http componentsSeparatedByString:@"&"]; // 获取单一参数
    NSArray *keyValue;
    NSString *param, *value;
    for (param in array) {
        keyValue = [param componentsSeparatedByString:@"="]; // 参数分离
        if (keyValue.count == 2) {
            value = encode ? YJNSURLDecode(keyValue.lastObject) : keyValue.lastObject;
        } else {
            value = @"";
        }
        [dict setObject:value forKey:keyValue.firstObject];
    }
    return dict;
}

+ (NSDictionary<NSString *,NSString *> *)analysisParams:(NSString *)http {
    return [self analysisParams:http URLEncode:NO];
}

+ (NSDictionary<NSString *, NSString *> *)analysisParamsDecode:(NSString *)http {
    return [self analysisParams:http URLEncode:YES];
}

+ (NSString *)analysisParams:(NSString *)http forKey:(NSString *)key {
    return [[self analysisParams:http] objectForKey:key];
}

+ (NSString *)analysisParamsDecode:(NSString *)http forKey:(NSString *)key {
    return  YJNSURLDecode([self analysisParams:http forKey:(NSString *)key]);
}

@end
