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

#import "YJTest+CoreDataClass.h"
//#import "YJTest1+CoreDataClass.h"
//#import "YJUser+CoreDataClass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    abort();
    [self testMigration];
    return YES;
}

#pragma mark 迁移数据
- (void)testMigration {
    NSURL *storeURL = [YJNSDirectoryS.documentURL URLByAppendingPathComponent:@"YJCoreData/CoreData.sqlite"];
    NSError *error;
    YJCDMSetup setup = [YJCDManagerS setupWithStoreURL:storeURL error:&error];
    // MigrationModel version1 -> 2
    if (setup == YJCDMSetupSuccess) { // 添加测试数据
        for (int i = 0;i<1000; i++) {
            YJTest *test = [YJTest insertNewObject];
            test.name = [NSString stringWithFormat:@"阳君-%d", i];
        }
        [YJCDManagerS saveInStore:^(BOOL success, NSError * _Nonnull error) {
            if (success) {
                abort();
            }
        }];
    } else if (setup == YJCDMSetupMigration) {
        
    } else {
        NSLog(@"%@", error);
    }
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
