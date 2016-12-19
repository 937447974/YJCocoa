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
#import "YJNSURLCode.h"

@implementation YJNSHttpAssembly

+ (NSString *)assemblyHttp:(NSDictionary *)params {
    return [self assemblyHttp:params URLEncode:NO];
}

+ (NSString *)assemblyHttpEncode:(NSDictionary *)params {
    return [self assemblyHttp:params URLEncode:YES];
}

+ (NSString *)assemblyHttp:(NSDictionary *)params URLEncode:(BOOL)encode {
    if (!params) return @"";
    NSMutableString *paramsString = [NSMutableString string];
    for (NSString *key in params) {
        [paramsString appendFormat:@"&%@=", key];
        [paramsString appendString:encode ? YJNSURLEncode(params[key]) : params[key]];
    }
    if (paramsString.length) {
        [paramsString deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    return paramsString;
}

#pragma mark
+ (NSString *)assemblyHttp:(NSString *)http params:(NSDictionary *)params {
    return [self assemblyHttp:http params:params URLEncode:NO];
}

+ (NSString *)assemblyHttpEncode:(NSString *)http params:(NSDictionary *)params {
    return [self assemblyHttp:http params:params URLEncode:YES];
}

+ (NSString *)assemblyHttp:(NSString *)http params:(NSDictionary *)params URLEncode:(BOOL)encode {
    NSRange start = [http rangeOfString:@"?"];
    if (start.location == NSNotFound) {
        return [NSString stringWithFormat:@"%@?%@", http, [self assemblyHttp:params URLEncode:encode]];
    }
        return [NSString stringWithFormat:@"%@%@", http, [self assemblyHttp:params URLEncode:encode]];
}

@end
