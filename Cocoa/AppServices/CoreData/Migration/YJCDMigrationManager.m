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
    NSURL *sourceURL = YJCDManagerS.storeURL;
    // Model
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:sourceURL error:&resultError];
    NSManagedObjectModel *sourceModel = [NSManagedObjectModel mergedModelFromBundles:nil forStoreMetadata:sourceMetadata];
    NSManagedObjectModel *destinationModel = YJCDManagerS.model;
    // mapping model
    NSMappingModel *mappingModel = [NSMappingModel mappingModelFromBundles:nil forSourceModel:sourceModel destinationModel:destinationModel];
    if (mappingModel) {
        // destination URL
        NSFileManager *fm = [NSFileManager defaultManager];
        NSURL *destinationURL = [YJNSDirectoryS.tempURL URLByAppendingPathComponent:@"YJCoreData"];
        [fm removeItemAtURL:destinationURL error:nil];
        [fm createDirectoryAtURL:destinationURL withIntermediateDirectories:YES attributes:nil error:&resultError];
        destinationURL = [destinationURL URLByAppendingPathComponent:sourceURL.lastPathComponent];
        // migration
        NSMigrationManager *migrationManager = [[NSMigrationManager alloc] initWithSourceModel:sourceModel destinationModel:destinationModel];
        [migrationManager addObserver:self forKeyPath:@"migrationProgress" options:NSKeyValueObservingOptionNew context:nil];
        BOOL success = [migrationManager migrateStoreFromURL:sourceURL type:NSSQLiteStoreType options:nil withMappingModel:mappingModel toDestinationURL:destinationURL destinationType:NSSQLiteStoreType destinationOptions:nil error:&resultError];
        [migrationManager removeObserver:self forKeyPath:@"migrationProgress"];
        if (success) {
            // move store
            if ([fm moveSafeItemAtURL:destinationURL toURL:sourceURL error:&resultError]) {
                [fm removeItemAtURL:[NSURL fileURLWithPath:[sourceURL.path stringByAppendingString:@"-shm"]] error:nil];
                [fm removeItemAtURL:[NSURL fileURLWithPath:[sourceURL.path stringByAppendingString:@"-wal"]] error:nil];
                [YJCDManagerS setupWithStoreURL:sourceURL error:&resultError];
            }
        } else {
            [migrationManager cancelMigrationWithError:resultError];
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
