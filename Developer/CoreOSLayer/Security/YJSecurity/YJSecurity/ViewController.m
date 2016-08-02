//
//  ViewController.m
//  YJSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/28.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJSecurity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self testRadom];
    [self testKeyChain];
}

- (void)testRadom {
    NSString *result = randomizationUppercase(32);
    NSLog(result, nil);
    result = randomizationLowercase(32);
    NSLog(result, nil);
    result = randomization(32);
    NSLog(result, nil);
    NSLog(@"%lu", (unsigned long)result.length);
}

- (void)testKeyChain {
    YJKeychainGPItem *item = [[YJKeychainGPItem alloc] init];
    OSStatus status;
    // 查询所有
    NSArray *allArray = KeychainItemSelectAll(item, nil);
    NSLog(@"%@", allArray);
    // 查询首个
    item.account = @"阳君";
    status = KeychainItemSelect(item);
    status = KeychainItemSelect(item);
    // 保存
    status = KeychainItemSave(item);
    status = KeychainItemSelect(item);
    // 修改
    item.desc = @"姓名";
    status = KeychainItemSave(item);
    status = KeychainItemSelect(item);
    // 再次保存
    YJKeychainGPItem *item2 = [[YJKeychainGPItem alloc] init];
    item2.account = @"937447974";
    item2.desc = @"qq";
    status = KeychainItemSave(item2);
    allArray = KeychainItemSelectAll(item, nil);
    NSLog(@"%@", allArray);
    // 删除item2
    status = KeychainItemDelete(item2);
    allArray = KeychainItemSelectAll(item, nil);
    NSLog(@"%@", allArray);
    // 重置
//    status = KeychainItemDelete([[YJKeychainGPItem alloc] init]);
    
    //    NSMutableDictionary *baseDict = [[NSMutableDictionary alloc] init];
    //    [baseDict setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    //    [baseDict setObject:@"1" forKey:(id)kSecAttrGeneric];
    //
    //    CFDictionaryRef result;
    //    [baseDict setObject:@"研究" forKey:(id)kSecAttrAccount];
    //    OSStatus status = SecItemAdd((CFDictionaryRef)baseDict, (CFTypeRef *)&result);
    //    [baseDict setObject:@"数目" forKey:(id)kSecAttrAccount];
    //    status = SecItemAdd((CFDictionaryRef)baseDict, (CFTypeRef *)&result);
    //    [baseDict setObject:@"数目1" forKey:(id)kSecAttrAccount];
    //    status = SecItemAdd((CFDictionaryRef)baseDict, (CFTypeRef *)&result);
    //
    //    NSMutableDictionary *updateDict = [NSMutableDictionary dictionary];
    //    [updateDict setObject:@"1" forKey:(id)kSecAttrDescription];
    //    status = SecItemUpdate((CFDictionaryRef)baseDict, (CFDictionaryRef)updateDict);
    //
    ////    SecItemAdd((CFDictionaryRef)genericPasswordQuery, NULL);
    ////    [genericPasswordQuery setObject:@"2" forKey:(id)kSecAttrLabel];
    ////    status = SecItemAdd((CFDictionaryRef)genericPasswordQuery, NULL);
    ////    [genericPasswordQuery setObject:@"3" forKey:(id)kSecAttrLabel];
    ////    status = SecItemAdd((CFDictionaryRef)genericPasswordQuery, NULL);
    //
    ////    [genericPasswordQuery removeObjectForKey:(NSString *)kSecAttrGeneric];
    //
    //
    //    baseDict = [[NSMutableDictionary alloc] init];
    //    [baseDict setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    //    [baseDict setObject:@"1" forKey:(id)kSecAttrGeneric];
    //    [baseDict setObject:(id)kSecMatchLimitAll forKey:(id)kSecMatchLimit];
    //    [baseDict setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    //
    //    status = SecItemCopyMatching((CFDictionaryRef)baseDict, (CFTypeRef *)&result);
    //    NSDictionary *outDictionary = (__bridge NSDictionary *)(result);
    //    NSLog(@"%@", outDictionary);
    //
    //    baseDict = [[NSMutableDictionary alloc] init];
    //    [baseDict setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    //    status = SecItemDelete((CFDictionaryRef)baseDict);
    //
    //    if (result) {
    //        CFRelease(result);
    //    }
}



+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    
    CFDictionaryRef cf_keychainQuery = (__bridge_retained CFDictionaryRef)keychainQuery;
    
    //Delete old item before add new item
    SecItemDelete(cf_keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd(cf_keychainQuery, NULL);
    CFRelease(cf_keychainQuery);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    CFDictionaryRef cf_keychainQuery = (__bridge_retained CFDictionaryRef)keychainQuery;
    if (SecItemCopyMatching(cf_keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (cf_keychainQuery) {
        CFRelease(cf_keychainQuery);
    }
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    CFDictionaryRef cf_keychainQuery = (__bridge_retained CFDictionaryRef)keychainQuery;
    SecItemDelete(cf_keychainQuery);
    CFRelease(cf_keychainQuery);
}


@end
