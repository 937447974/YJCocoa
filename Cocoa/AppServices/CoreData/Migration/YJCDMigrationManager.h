//
//  YJCDMigrationManager.h
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

/** 迁移管理器，主要用于数据库迁移升级*/
@interface YJCDMigrationManager : NSObject

@property (nonatomic, copy) void (^ migrationProgress)(float progress); ///< 迁移进度[0,1]

/**
 *  @abstract 执行迁移升级数据库操作
 *  @discusstion 会堵塞线程，建议后台执行
 *
 *  @param error 错误信息
 *
 *  @return BOOL
 */
- (BOOL)migrateStore:(NSError * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END
