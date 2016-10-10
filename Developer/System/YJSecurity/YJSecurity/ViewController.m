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
    [self testRadom];
    [self testKeyChain];
}

- (void)testRadom {
    NSString *result = YJSecRandomU(32);
    NSLog(result, nil);
    result = YJSecRandomL(32);
    NSLog(result, nil);
    result = YJSecRandomUL(32);
    NSLog(result, nil);
    NSLog(@"%lu", (unsigned long)result.length);
}

- (void)testKeyChain {
    OSStatus status;
    // 查询所有
    NSArray *allArray = YJSecKeychainItemSelectAll([[YJSecKeychainGPItem alloc] init], nil);
    NSLog(@"%@", allArray);
    // 查询首个
    YJSecKeychainGPItem *item = [[YJSecKeychainGPItem alloc] init];
    item.account = @"阳君";
    status = YJSecKeychainItemSelect(item);
    status = YJSecKeychainItemSelect(item);
    // 保存
    status = YJSecKeychainItemSave(item);
    status = YJSecKeychainItemSelect(item);
    // 修改
    item.desc = @"姓名";
    status = YJSecKeychainItemSave(item);
    status = YJSecKeychainItemSelect(item);
    // 再次保存
    YJSecKeychainGPItem *item2 = [[YJSecKeychainGPItem alloc] init];
    item2.account = @"937447974";
    item2.desc = @"qq";
    status = YJSecKeychainItemSave(item2);
    allArray = YJSecKeychainItemSelectAll([[YJSecKeychainGPItem alloc] init], &status);
    NSLog(@"%@", allArray);
    // 删除item2
    status = YJSecKeychainItemDelete(item2);
    allArray = YJSecKeychainItemSelectAll([[YJSecKeychainGPItem alloc] init], nil);
    NSLog(@"%@", allArray);
    // 重置
    status = YJSecKeychainItemDelete([[YJSecKeychainGPItem alloc] init]);
    allArray = YJSecKeychainItemSelectAll([[YJSecKeychainGPItem alloc] init], nil);
    NSLog(@"%@", allArray);
}

@end
