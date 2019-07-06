//
//  YJNSLog.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/20.
//  Copyright © 2016-现在 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, YJLogLevel){
    YJLogLevelVerbose = 1 << 0, ///< YJCocoa 库日志
    YJLogLevelDebug   = 1 << 1,
    YJLogLevelInfo    = 1 << 2,
    YJLogLevelWarn    = 1 << 3,
    YJLogLevelError   = 1 << 4
};

typedef void (^ YJLogBlock)(YJLogLevel level, NSString *str);

FOUNDATION_EXPORT void YJLogVerbose(NSString *format, ...);
FOUNDATION_EXPORT void YJLogDebug(NSString *format, ...);
FOUNDATION_EXPORT void YJLogInfo(NSString *format, ...);
FOUNDATION_EXPORT void YJLogWarn(NSString *format, ...);
FOUNDATION_EXPORT void YJLogError(NSString *format, ...);

/** 日志输出*/
@interface YJNSLog : NSObject

@property (nonatomic, class) YJLogLevel logLevel; ///< 日志级别
@property (nonatomic, copy, class) YJLogBlock logBLock; ///< 日志输出

@end

NS_ASSUME_NONNULL_END
