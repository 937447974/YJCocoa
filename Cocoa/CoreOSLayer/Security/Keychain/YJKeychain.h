//
//  YJKeychain.h
//  YJSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/28.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJKeychainGPItem.h"

NS_ASSUME_NONNULL_BEGIN

// OSStatus : errSecSuccess(成功)，其他见SecBase.h
// 自定义accessGroup需Build Settings -> Code SigningEntitlements - ${SRCROOT}/$(PRODUCT_NAME)/Keychain.plist

/** 查询首个匹配的KeychainItem*/
FOUNDATION_EXPORT OSStatus KeychainItemSelect(YJKeychainItem *item);
/** 查询所有匹配的YJKeychainItem*/
FOUNDATION_EXPORT NSArray<YJKeychainItem *> * KeychainItemSelectAll(YJKeychainItem *item, OSStatus * _Nullable status);

/** 保存YJKeychainItem*/
FOUNDATION_EXPORT OSStatus KeychainItemSave(YJKeychainItem *item);

/** 删除YJKeychainItem*/
FOUNDATION_EXPORT OSStatus KeychainItemDelete(YJKeychainItem *item);

NS_ASSUME_NONNULL_END
