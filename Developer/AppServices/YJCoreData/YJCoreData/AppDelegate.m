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
#import "YJCoreData.h"

#import "YJNSDirectory.h"
#import "YJDispatch.h"

#define version1 0

#if version1
#import "YJTest+CoreDataClass.h"
#else
#import "YJUsers+CoreDataClass.h"
#import "YJPhone+CoreDataClass.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self testMigration];
    
     NSObject *obj = [NSObject new];
    [[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(testMigration) name:@"11" object:nil];
    __weak NSObject *obj2 = obj;
    dispatch_async_main(^{
        NSLog(@"%@", obj2);
        //NSLog(@"%@", obj);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"11" object:nil];
    });
    
    return YES;
}

#pragma mark 迁移数据
- (void)testMigration {
    NSURL *storeURL = [YJNSDirectoryS.documentURL URLByAppendingPathComponent:@"YJCoreData/CoreData.sqlite"];
    NSLog(@"%@", storeURL);
    NSError *error;
    YJCDMSetup setup = [YJCDManagerS setupWithStoreURL:storeURL error:&error];
    // MigrationModel version1 -> 2
    if (setup == YJCDMSetupSuccess) { // 添加测试数据
#if version1
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 1000000; i++) {
            YJTest *test = [YJTest insertNewObject];
            test.names = [NSString stringWithFormat:@"阳君-%d", i];
            [array addObject:test];

        }
        [YJCDManagerS saveInStore:^(BOOL success, NSError * _Nonnull error) {
            if (success) {
                [YJCDManagerS.mainContext deleteObject:[array objectAtIndex:5]];
                [YJCDManagerS saveInStore:^(BOOL success, NSError * _Nonnull error) {
                    abort();
                }];
            } else {
                NSLog(@"%@", error);
            }
        }];
#else
        YJUsers *user = [YJUsers insertNewObject];
        [YJCDManagerS saveInStore:nil];
#endif
    } else if (setup == YJCDMSetupMigration) {
        dispatch_async_background(^{
            YJCDMigrationManager *mm = [[YJCDMigrationManager alloc] init];
            NSLog(@"数据库升级是否成功：%d", [mm migrateStore:nil]);
        });
    } else {
        NSLog(@"%@", error);
    }
}

#pragma mark 导入数据
- (void)testImport {
    NSURL *storeURL = [YJNSDirectoryS.documentURL URLByAppendingPathComponent:@"YJCoreData/CoreData.sqlite"];
    [YJCDManagerS setupWithStoreURL:storeURL error:nil];
}

@end
