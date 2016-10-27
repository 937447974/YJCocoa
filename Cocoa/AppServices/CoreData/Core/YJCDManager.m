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
        
    } else {
        NSURL *storeDirectory = storeURL.URLByDeletingLastPathComponent;
        if (![fm fileExistsAtPath:storeDirectory.path]) {
            result = [fm createDirectoryAtURL:storeDirectory withIntermediateDirectories:YES attributes:nil error:error];
        }
        if (result) {
            self.store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:error];
        }        
    }
    if (result) {
        return YJCDMSetupSuccess;
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
