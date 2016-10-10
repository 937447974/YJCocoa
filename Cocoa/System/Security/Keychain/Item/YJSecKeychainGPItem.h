//
//  YJSecKeychainGPItem.h
//  YJSecSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/2.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJSecKeychainItem.h"

NS_ASSUME_NONNULL_BEGIN

/** 存储kSecClassGenericPassword(一般密码)数据*/
@interface YJSecKeychainGPItem : YJSecKeychainItem <YJSecKItemGenericPasswordAttribute>

@end

NS_ASSUME_NONNULL_END
