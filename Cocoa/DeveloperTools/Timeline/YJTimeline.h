//
//  YJTimeline.h
//  YJCocoa
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2019/1/19.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 时间轴记录*/
@interface YJTimeline : NSObject

/**
 *  @abstract 添加时间轴步骤
 *
 *  @param steps 步骤描述
 */
+ (void)addSteps:(NSString *)steps;

/**
 *  @abstract 结束并打印日志
 */
+ (void)end;

@end

NS_ASSUME_NONNULL_END
