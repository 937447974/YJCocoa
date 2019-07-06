//
//  YJNSLog.m
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/20.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

#import "YJNSLog.h"

#define YJLogFormat va_list args;\
va_start(args, format);\
NSString *str = [[NSString alloc] initWithFormat:format arguments:args];\
va_end(args);

void YJLogVerbose(NSString *format, ...) {
    YJLogFormat
    YJNSLog.logBLock(YJLogLevelVerbose, str);
}
void YJLogDebug(NSString *format, ...) {
    YJLogFormat
    YJNSLog.logBLock(YJLogLevelDebug, str);
}
void YJLogInfo(NSString *format, ...) {
    YJLogFormat
    YJNSLog.logBLock(YJLogLevelInfo, str);
}
void YJLogWarn(NSString *format, ...) {
    YJLogFormat
    YJNSLog.logBLock(YJLogLevelWarn, str);
}
void YJLogError(NSString *format, ...) {
    YJLogFormat
    YJNSLog.logBLock(YJLogLevelError, str);
}

@implementation YJNSLog
static YJLogBlock _logBLock;
YJLogLevel _logLevel;

+ (void)initialize {
    if (self == [YJNSLog class]) {
#ifdef DEBUG
        YJNSLog.logLevel = YJLogLevelDebug | YJLogLevelInfo | YJLogLevelWarn | YJLogLevelError;
#else
        YJNSLog.logLevel = YJLogLevelInfo | YJLogLevelWarn | YJLogLevelError;
#endif
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans-CN"]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        YJNSLog.logBLock = ^(YJLogLevel level, NSString *str) {
            if (!(level & YJNSLog.logLevel)) return;
            NSMutableString *mstr = [NSMutableString stringWithString:[formatter stringFromDate:NSDate.date]];
            if (level & YJLogLevelVerbose) [mstr appendString:@" [🍏] "];
            else if (level & YJLogLevelDebug) [mstr appendString:@" [⚙] "];
            else if (level & YJLogLevelInfo) [mstr appendString:@" [💚] "];
            else if (level & YJLogLevelWarn) [mstr appendString:@" [⚠️] "];
            else if (level & YJLogLevelError) [mstr appendString:@" [❤️] "];
            [mstr appendString:str];
            printf("%s\n", mstr.UTF8String);
        };
    }
}

+(void)setLogBLock:(YJLogBlock)logBLock {
    _logBLock = logBLock;
}

+ (YJLogBlock)logBLock {
    return _logBLock;
}

+ (void)setLogLevel:(YJLogLevel)logLevel {
    _logLevel = logLevel;
}

+ (YJLogLevel)logLevel {
    return _logLevel;
}

@end

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

// 样式：[NSArray]、{NSDictionary}、{(NSSet)}

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
