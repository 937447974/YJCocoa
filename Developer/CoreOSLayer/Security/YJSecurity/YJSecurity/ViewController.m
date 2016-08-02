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
    OSStatus status;
    // 查询所有
    NSArray *allArray = KeychainItemSelectAll([[YJKeychainGPItem alloc] init], nil);
    NSLog(@"%@", allArray);
    // 查询首个
    YJKeychainGPItem *item = [[YJKeychainGPItem alloc] init];
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
    allArray = KeychainItemSelectAll([[YJKeychainGPItem alloc] init], &status);
    NSLog(@"%@", allArray);
    // 删除item2
    status = KeychainItemDelete(item2);
    allArray = KeychainItemSelectAll([[YJKeychainGPItem alloc] init], nil);
    NSLog(@"%@", allArray);
    // 重置
    status = KeychainItemDelete([[YJKeychainGPItem alloc] init]);
    allArray = KeychainItemSelectAll([[YJKeychainGPItem alloc] init], nil);
    NSLog(@"%@", allArray);
}

@end
