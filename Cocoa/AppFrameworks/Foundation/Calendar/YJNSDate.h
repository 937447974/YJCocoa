//
//  YJNSDate.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2017/1/5.
//  Copyright © 2017年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 日期从0开始*/
@interface YJNSDate : NSObject

@property (nonatomic) NSTimeInterval second; ///< 秒

/**
 *  @abstract 通过秒初始化
 *
 *  @param second 秒
 *
 *  @return instancetype
 */
- (instancetype)initWithSecond:(NSTimeInterval)second;

@end

NS_ASSUME_NONNULL_END
