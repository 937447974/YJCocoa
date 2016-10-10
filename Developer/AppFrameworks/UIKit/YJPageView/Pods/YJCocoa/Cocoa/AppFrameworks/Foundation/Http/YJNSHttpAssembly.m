//
//  YJNSHttpAssembly.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/6/30.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSHttpAssembly.h"

@implementation YJNSHttpAssembly

+ (NSString *)assemblyHttp:(NSDictionary *)params {
    if (!params) return @"";
    NSMutableString *paramsString = [NSMutableString string];
    for (NSString *key in params) {
        [paramsString appendFormat:@"&%@=%@", key, params[key]];
    }
    if (paramsString.length) {
        [paramsString deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    return paramsString;
}

+ (NSString *)assemblyHttp:(NSString *)http params:(NSDictionary *)params {
    NSRange start = [http rangeOfString:@"?"];
    if (start.location == NSNotFound) {
        return [NSString stringWithFormat:@"%@?%@", http, [self assemblyHttp:params]];
    } else {
        return [NSString stringWithFormat:@"%@%@", http, [self assemblyHttp:params]];
    }
}

@end
