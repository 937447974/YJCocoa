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
    for (NSString *param in array) {
        range = [param rangeOfString:@"="]; // 参数分离
        if (range.location != NSNotFound) {
            NSString *value = range.location+1 == param.length ? @"" : [param substringFromIndex:range.location+1];
            value = encode ? YJNSURLDecode(value) : value;
            [dict setObject:value forKey:[param substringToIndex:range.location]];
        } else {
            [dict setObject:@"" forKey:param];
        }
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
