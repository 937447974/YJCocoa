//
//  AppDelegate.m
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "AppDelegate.h"
#import "YJCDCoreData.h"
#import "YJNSDirectory.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    NSURL *storeURL = [YJNSDirectoryS.documentURL URLByAppendingPathComponent:@"YJCoreData/CoreData.sqlite"];
//    [YJCDManagerS setupWithStoreURL:storeURL error:nil];
    return YES;
}

#pragma mark 迁移数据
- (void)testMigration {
    NSURL *storeURL = [YJNSDirectoryS.documentURL URLByAppendingPathComponent:@"YJCoreData/CoreData.sqlite"];
    NSError *error;
    [YJCDManagerS setupWithStoreURL:storeURL error:&error];
}

#pragma mark 导入数据
- (void)testImport {
    NSURL *storeURL = [YJNSDirectoryS.documentURL URLByAppendingPathComponent:@"YJCoreData/CoreData.sqlite"];
    [YJCDManagerS setupWithStoreURL:storeURL error:nil];
}

#pragma mark 性能测试
- (void)testPerformance {
    NSURL *storeURL = [YJNSDirectoryS.documentURL URLByAppendingPathComponent:@"YJCoreData/CoreData.sqlite"];
    NSError *error;
    [YJCDManagerS setupWithStoreURL:storeURL error:&error];
}

@end
