//
//  YJCDManager.h
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "YJNSSingletonMCenter.h"

NS_ASSUME_NONNULL_BEGIN

// YJCDManager单例
#define YJCDManagerS ((YJCDManager *)[YJNSSingletonMC registerStrongSingleton:[YJCDManager class]])

/** CoreData设置的结果*/
typedef NS_ENUM(NSInteger, YJCDMSetup) {
    YJCDMSetupSuccess,  ///< 设置成功
    YJCDMSetupError,    ///< 设置失败
    YJCDMSetupMigration ///< 需要迁移升级
};

/** CoreData核心管理类*/
@interface YJCDManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *rootContext; ///< 根托管对象上下文(NSPrivateQueueConcurrencyType)
@property (nonatomic, strong) NSManagedObjectContext *mainContext; ///< 主托管对象上下文(NSMainQueueConcurrencyType)

@property (nonatomic, strong) NSManagedObjectModel *model;               ///< 托管对象模型
@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator; ///< 持久化存储协调器
@property (nonatomic, strong) NSPersistentStore *store;                  ///< 持久化存储区

/**
 *  @abstract 通过持久化存储区地址设置相关参数
 *  @discusstion 请在application:didFinishLaunchingWithOptions:中调用[YJCDManagerS setupWithStoreURL:storeURL error:&error]
 *
 *  @param storeURL 持久化存储区地址
 *  @param error    错误信息
 *
 *  @return YJCDMSetup
 */
- (YJCDMSetup)setupWithStoreURL:(NSURL *)storeURL error:(NSError **)error;


@end

NS_ASSUME_NONNULL_END
