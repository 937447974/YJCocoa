//
//  YJTimeProfiler.h
//  YJTimeProfiler
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/11.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 时间分析器*/
@interface YJTimeProfiler : NSObject

@property (class, nonatomic, strong, readonly) YJTimeProfiler *shared; ///< 共享

@property (nonatomic) BOOL start; ///< 是否启动

@property (nonatomic) NSInteger frequency;     ///< 分析频率，默认1秒
@property (nonatomic) NSTimeInterval interval; ///< 帧间隔，默认0.17秒

@end

NS_ASSUME_NONNULL_END
