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
#import "YJCDManager.h"
#import "YJNSDirectory.h"
#import "YJNSFileManager.h"

@implementation YJCDMigrationManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.migrationProgress = ^(float progress) {
            int percentage = progress * 100;
            NSLog(@"已完成迁移: %i%%", percentage);
        };
    }
    return self;
}

- (BOOL)migrateStore {
    NSError *resultError = nil;
    // Model
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:YJCDManagerS.storeURL error:&resultError];
    NSManagedObjectModel *sourceModel = [NSManagedObjectModel mergedModelFromBundles:nil forStoreMetadata:sourceMetadata];
    NSManagedObjectModel *destinModel = YJCDManagerS.model;
    // mapping model
    NSMappingModel *mappingModel = [NSMappingModel mappingModelFromBundles:nil forSourceModel:sourceModel destinationModel:destinModel];
    if (mappingModel) {
        // migration
        NSMigrationManager *migrationManager = [[NSMigrationManager alloc] initWithSourceModel:sourceModel destinationModel:destinModel];
        [migrationManager addObserver:self forKeyPath:@"migrationProgress" options:NSKeyValueObservingOptionNew context:nil];
        NSURL *destinStore = [YJNSDirectoryS.tempURL URLByAppendingPathComponent:@"YJCoreDataTemp.sqlite"];
        BOOL success = [migrationManager migrateStoreFromURL:YJCDManagerS.storeURL type:NSSQLiteStoreType options:nil withMappingModel:mappingModel toDestinationURL:destinStore destinationType:NSSQLiteStoreType destinationOptions:nil error:&resultError];
        [migrationManager removeObserver:self forKeyPath:@"migrationProgress"];
        NSFileManager *fm = [NSFileManager defaultManager];
        if (success) {
            // move store
            if ([fm moveSafeItemAtURL:destinStore toURL:YJCDManagerS.storeURL error:&resultError]) {
                [YJCDManagerS setupWithStoreURL:YJCDManagerS.storeURL error:&resultError];
            }
        } else {
            [migrationManager cancelMigrationWithError:resultError];
            [fm removeItemAtURL:destinStore error:nil];
            NSLog(@"迁移失败: %@", resultError);
        }
    } else {
        resultError = [NSError errorWithDomain:@"迁移失败:映射模型是null！" code:YJCDMSetupMigration userInfo:nil];
    }
    self.migrateError = resultError;
    return !self.migrateError;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([@"migrationProgress" isEqualToString:keyPath]) {
        float progress = [[change objectForKey:NSKeyValueChangeNewKey] floatValue];
        self.migrationProgress(progress);
    }
}

@end
