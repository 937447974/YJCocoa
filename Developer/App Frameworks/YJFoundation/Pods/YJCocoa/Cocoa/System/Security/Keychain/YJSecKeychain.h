//
//  YJSecKeychain.h
//  YJSecSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/28.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJSecKeychainGPItem.h"

NS_ASSUME_NONNULL_BEGIN

// OSStatus : errSecSuccess(成功)，其他见SecBase.h
// 自定义accessGroup需Build Settings -> Code SigningEntitlements - ${SRCROOT}/$(PRODUCT_NAME)/Keychain.plist

/** 查询首个匹配的YJSecKeychainItem*/
FOUNDATION_EXPORT OSStatus YJSecKeychainItemSelect(YJSecKeychainItem *item);
/** 查询所有匹配的YJSecKeychainItem*/
FOUNDATION_EXPORT NSArray<YJSecKeychainItem *> *YJSecKeychainItemSelectAll(YJSecKeychainItem *item, OSStatus * _Nullable status);

/** 保存YJSecKeychainItem*/
FOUNDATION_EXPORT OSStatus YJSecKeychainItemSave(YJSecKeychainItem *item);

/** 删除YJSecKeychainItem*/
FOUNDATION_EXPORT OSStatus YJSecKeychainItemDelete(YJSecKeychainItem *item);

NS_ASSUME_NONNULL_END
