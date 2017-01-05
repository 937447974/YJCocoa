//
//  YJNSDateComponents.h
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

/** 日期组件NSDateComponents*/
@interface YJNSDateComponents : NSObject

@property (nonatomic) NSInteger day;         ///< 天
@property (nonatomic) NSInteger hour;        ///< 时
@property (nonatomic) NSInteger minute;      ///< 分
@property (nonatomic) NSTimeInterval second; ///< 秒

@end

NS_ASSUME_NONNULL_END
