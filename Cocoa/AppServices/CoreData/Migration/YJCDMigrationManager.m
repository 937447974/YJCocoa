//
//  YJCDMigrationManager.m
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJCDMigrationManager.h"

@implementation YJCDMigrationManager

- (BOOL)migrateStore {
    BOOL success = NO;
    NSError *error = nil;
    
    // 步骤1 收集来源、目的地和映射模型
    // 数据源
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:sourceStore error:&error];// 数据源
    // 源模型
    NSManagedObjectModel *sourceModel = [NSManagedObjectModel mergedModelFromBundles:nil forStoreMetadata:sourceMetadata];
    // 目标模型
    NSManagedObjectModel *destinModel = _model;
    // 映射模型
    NSMappingModel *mappingModel = [NSMappingModel mappingModelFromBundles:nil forSourceModel:sourceModel destinationModel:destinModel];
    
    // 步骤2 执行迁移,假设映射模型不是null
    if (mappingModel) {
        NSError *error = nil;
        // 临时存储区
        NSMigrationManager *migrationManager = [[NSMigrationManager alloc] initWithSourceModel:sourceModel destinationModel:destinModel];
        [migrationManager addObserver:self forKeyPath:@"migrationProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        NSURL *destinStore = [[self applicationStoresDirectory] URLByAppendingPathComponent:@"Temp.sqlite"];
        
        success = [migrationManager migrateStoreFromURL:sourceStore type:NSSQLiteStoreType options:nil withMappingModel:mappingModel toDestinationURL:destinStore destinationType:NSSQLiteStoreType destinationOptions:nil error:&error];
        if (success)
        {
            // 步骤3 取代旧的存储与新存储迁移
            if ([self replaceStore:sourceStore withStore:destinStore])
            {
                NSLog(@"成功迁移%@到当前Model", sourceStore.path);
                [migrationManager removeObserver:self forKeyPath:@"migrationProgress"];
            }
        }
        else
        {
            NSLog(@"迁移失败: %@",error);
        }
    }
    else
    {
        NSLog(@"迁移失败:映射模型是null");
    }
    // 表明迁移完成,不管结果
    return YES;

}

@end
