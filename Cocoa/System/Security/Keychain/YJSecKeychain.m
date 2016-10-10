//
//  YJSecKeychain.m
//  YJSecSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/28.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJSecKeychain.h"

// 查询首个匹配的YJSecKeychainItem
OSStatus YJSecKeychainItemSelect(YJSecKeychainItem *item) {
    [item.selectDict setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    [item.selectDict setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    CFDictionaryRef result = NULL;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)item.selectDict, (CFTypeRef *)&result);
    if (status == errSecSuccess) {
        NSDictionary *dict = (__bridge NSDictionary *)(result);
        item.strongDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    if (result) {
        CFRelease(result);
    }
    return status;
}

// 查询所有匹配的YJSecKeychainItem
NSArray<YJSecKeychainItem *> * YJSecKeychainItemSelectAll(YJSecKeychainItem *item, OSStatus * _Nullable status) {
    [item.selectDict setObject:(id)kSecMatchLimitAll forKey:(id)kSecMatchLimit];
    [item.selectDict setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    CFArrayRef result = NULL;
    OSStatus cm = SecItemCopyMatching((CFDictionaryRef)item.selectDict, (CFTypeRef *)&result);
    if (status) {
        status = &cm;
    }
    NSMutableArray<YJSecKeychainItem *> *array = [NSMutableArray array];
    if (cm == errSecSuccess) {
        NSArray *rArray = (__bridge NSArray *)(result);
        for (NSDictionary *dict in rArray) {
            YJSecKeychainItem *rItem = [item.class new];
            rItem.strongDict = [NSMutableDictionary dictionaryWithDictionary:dict];
            [array addObject:rItem];
        }
    }
    if (result) {
        CFRelease(result);
    }
    return array;
}

// 保存YJSecKeychainItem
OSStatus YJSecKeychainItemSave(YJSecKeychainItem *item) {
    // pull
    YJSecKeychainItem *mcItem = [item mutableCopy];
    OSStatus status = YJSecKeychainItemSelect(mcItem);
    // push
    [item.selectDict removeObjectForKey:(id)kSecMatchLimit];
    [item.selectDict removeObjectForKey:(id)kSecReturnAttributes];
    if (status == errSecSuccess) {
        [item.weakDict removeObjectsForKeys:item.selectDict.allKeys];
        if (item.weakDict.count) {
            status = SecItemUpdate((CFDictionaryRef)item.selectDict, (CFDictionaryRef)item.weakDict);
        }
    } else if (status == errSecItemNotFound) {
        [item.weakDict addEntriesFromDictionary:item.selectDict];
        status = SecItemAdd((CFDictionaryRef)item.weakDict, NULL);
    }
    // pull
    if (status == errSecSuccess && item.weakDict.count) {
        status = YJSecKeychainItemSelect(item);
    }
    return status;
}

// 删除YJSecKeychainItem
OSStatus YJSecKeychainItemDelete(YJSecKeychainItem *item) {
    [item.selectDict removeObjectForKey:(id)kSecMatchLimit];
    [item.selectDict removeObjectForKey:(id)kSecReturnAttributes];
    OSStatus status = SecItemDelete((CFDictionaryRef)item.selectDict);
    return status;
}

