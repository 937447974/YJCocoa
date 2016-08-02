//
//  YJKeychain.m
//  YJSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/28.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJKeychain.h"

// 查询首个匹配的KeychainItem
OSStatus KeychainItemSelect(YJKeychainItem *item) {
    [item.saveDict setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    [item.saveDict setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    [item.saveDict removeObjectForKey:(id)kSecAttrModificationDate];
    [item.saveDict removeObjectForKey:(id)kSecAttrCreationDate];
    [item.saveDict removeObjectForKey:(id)kSecAttrService];
    [item.saveDict removeObjectForKey:(id)kSecAttrGeneric];
    
     [item.saveDict removeObjectForKey:(id)kSecAttrDescription];
     [item.saveDict removeObjectForKey:(id)kSecAttrComment];
     [item.saveDict removeObjectForKey:(id)kSecAttrCreator];
     [item.saveDict removeObjectForKey:(id)kSecAttrType];
     [item.saveDict removeObjectForKey:(id)kSecAttrGeneric];
    
//    kSecAttrAccessible
//    kSecAttrAccessControl
//    kSecAttrAccessGroup
//    kSecAttrCreationDate
//    kSecAttrModificationDate
//    kSecAttrDescription
//    kSecAttrComment
//    kSecAttrCreator
//    kSecAttrType
//    kSecAttrLabel
//    kSecAttrIsInvisible
//    kSecAttrIsNegative
//    kSecAttrAccount
//    kSecAttrService
//    kSecAttrGeneric
//    kSecAttrSynchronizable
    
    
    
    
    CFDictionaryRef result = NULL;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)item.saveDict, (CFTypeRef *)&result);
    if (status == errSecSuccess) {
        item.matchingDict = (__bridge NSDictionary *)(result);
    } else {
        [item.saveDict removeObjectForKey:(id)kSecReturnAttributes];
        [item.saveDict removeObjectForKey:(id)kSecMatchLimit];
    }
    if (result) {
        CFRelease(result);
    }
    return status;
}

// 查询所有匹配的YJKeychainItem
NSArray<YJKeychainItem *> * KeychainItemSelectAll(YJKeychainItem *item, OSStatus * _Nullable status) {
    [item.saveDict setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    [item.saveDict setObject:(id)kSecMatchLimitAll forKey:(id)kSecMatchLimit];
    CFArrayRef result = NULL;
    OSStatus cm = SecItemCopyMatching((CFDictionaryRef)item.saveDict, (CFTypeRef *)&result);
    if (status) {
        status = &cm;
    }
    NSMutableArray<YJKeychainItem *> *array = [NSMutableArray array];
    if (cm == errSecSuccess) {
        NSArray *rArray = (__bridge NSArray *)(result);
        for (NSDictionary *dict in rArray) {
            YJKeychainItem *rItem = [item.class new];
            rItem.matchingDict = dict;
            [array addObject:rItem];
        }
    }
    if (result) {
        CFRelease(result);
    }
    return array;
}

// 保存YJKeychainItem
OSStatus KeychainItemSave(YJKeychainItem *item) {
    YJKeychainItem *mcItem = [item mutableCopy];
    OSStatus status = KeychainItemSelect(mcItem);
    if (status == errSecSuccess) {
        for (id key in item.matchingDict.allKeys) {
            if ([[item.matchingDict objectForKey:key] isEqual:[item.saveDict objectForKey:key]]) {
                [item.saveDict removeObjectForKey:key];
            }
        }
        if (item.saveDict.count) {            
            status = SecItemUpdate((CFDictionaryRef)item.matchingDict, (CFDictionaryRef)item.saveDict);
        }
    } else {
        status = SecItemAdd((CFDictionaryRef)item.saveDict, NULL);
    }
    return status;
}

// 删除YJKeychainItem
OSStatus KeychainItemDelete(YJKeychainItem *item) {
    OSStatus status = KeychainItemSelect(item);
    if (status == errSecSuccess) {
        status = SecItemDelete((CFDictionaryRef)item.matchingDict);
    }
    return status;
}

