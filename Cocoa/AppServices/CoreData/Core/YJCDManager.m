//
//  YJCDManager.m
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJCDManager.h"

@implementation YJCDManager

- (YJCDMSetup)setupWithStoreURL:(NSURL *)storeURL error:(NSError * _Nullable __autoreleasing *)error {
    if (self.store) {
        return YJCDMSetupSuccess;
    }
    NSError *resultError = nil;
    self.rootContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [self.rootContext performBlockAndWait:^{
        self.rootContext.persistentStoreCoordinator = self.coordinator;
        self.rootContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    }];
    self.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.mainContext.parentContext = self.rootContext;
    self.mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL result = YES;
    if ([fm fileExistsAtPath:storeURL.path]) {
        NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:storeURL error:&resultError];
        [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:<#(nonnull NSString *)#> URL:<#(nonnull NSURL *)#> options:<#(nullable NSDictionary *)#> error:<#(NSError * _Nullable __autoreleasing * _Nullable)#>]
        NSManagedObjectModel *destinationModel = self.coordinator.managedObjectModel;
        if ([destinationModel isConfiguration:nil compatibleWithStoreMetadata:sourceMetadata])
        {
            NSLog(@"跳过迁移:源已经是兼容的");
            return NO;
        }
        return YES;
    } else {
        NSURL *storeDirectory = storeURL.URLByDeletingLastPathComponent;
        if (![fm fileExistsAtPath:storeDirectory.path]) {
            result = [fm createDirectoryAtURL:storeDirectory withIntermediateDirectories:YES attributes:nil error:&resultError];
        }
    }
    if (result) {
        self.store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&resultError];
    }
    resultError = [NSError errorWithDomain:@"持久化存储区需要迁移升级，可使用YJCDMigrationManager做迁移升级！" code:YJCDMSetupMigration userInfo:nil];
    if (!resultError) {
        return YJCDMSetupSuccess;
    }
    if (error) {
        *error = resultError;
    }
    return YJCDMSetupError;
}

#pragma mark getter & setter
- (NSManagedObjectModel *)model {
    if (!_model) {
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return _model;
}

- (NSPersistentStoreCoordinator *)coordinator {
    if (!_coordinator) {
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
    }
    return _coordinator;
}

@end
