//
//  YJNSURLCode.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/16.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  @abstract URLEncode编码
 *
 *  @param code 被编译字符串
 *
 *  @return NSString
 */
FOUNDATION_EXPORT NSString * _Nullable YJNSURLEncode(NSString *code);

/**
 *  @abstract URLDecode解码
 *
 *  @param code 被编译字符串
 *
 *  @return NSString
 */
FOUNDATION_EXPORT NSString * _Nullable YJNSURLDecode(NSString *code);

NS_ASSUME_NONNULL_END

