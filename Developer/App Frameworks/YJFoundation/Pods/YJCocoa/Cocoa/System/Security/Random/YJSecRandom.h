//
//  YJSecRandom.h
//  YJCSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/29.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  生成指定位数的随机密码（字母全大写）
 *
 *  @param count bytes数
 *
 *  @return NSString length=2*count
 */
FOUNDATION_EXPORT NSString *YJSecRandomU(size_t count);

/**
 *  生成指定位数的随机密码（字母全小写）
 *
 *  @param count bytes数
 *
 *  @return NSString length=2*count
 */
FOUNDATION_EXPORT NSString *YJSecRandomL(size_t count);

/**
 *  生成指定位数的随机密码（字母大写或小写，耗时)
 *
 *  @param count bytes数
 *
 *  @return NSString length=2*count
 */
FOUNDATION_EXPORT NSString *YJSecRandomUL(size_t count);

NS_ASSUME_NONNULL_END


