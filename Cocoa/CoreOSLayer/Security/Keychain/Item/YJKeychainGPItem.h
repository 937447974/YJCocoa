//
//  YJKeychainGPItem.h
//  YJSecurity
//
//  Created by admin on 16/8/2.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJKeychainItem.h"

/** 存储kSecClassGenericPassword数据*/
@interface YJKeychainGPItem : YJKeychainItem <YJKItemGenericPasswordAttribute>

@end
