//
//  YJCDImportManager.m
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJCDImportManager.h"
#import "YJCDFaulter.h"
#import "YJCDManager.h"

@interface YJCDImportManager ()

@property (nonatomic, strong) NSManagedObjectContext *importContext; ///< 托管对象上下文

@end

@implementation YJCDImportManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.targetContext = YJCDManagerS.rootContext;
        self.entities = self.targetContext.persistentStoreCoordinator.managedObjectModel.entitiesByName.allKeys;
        self.importProgress = ^(float progress) {
            int percentage = progress * 100;
            NSLog(@"已完成导入: %i%%", percentage);
        };        
    }
    return self;
}

- (void)setTargetContext:(NSManagedObjectContext *)targetContext {
    _targetContext = targetContext;
    self.importContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [self.importContext performBlockAndWait:^{
        NSManagedObjectModel *mObjectModel = targetContext.persistentStoreCoordinator.managedObjectModel;
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mObjectModel];
        _importContext.persistentStoreCoordinator = coordinator;
    }];
}

- (BOOL)importWithStoreURL:(NSURL *)storeURL {
    NSError *error;
    NSDictionary *options = [NSDictionary dictionaryWithObject:@YES forKey:NSReadOnlyPersistentStoreOption];
    [self.importContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
    self.importError = error;
    if (self.importError) {
        return NO;
    }
    
    return !self.importError;
    
}

- (NSString*)uniqueAttributeForEntity:(NSString*)entity {
    return [self.entitiesWithUniqueAttributes valueForKey:entity];
}

- (NSManagedObject*)existingObjectInContext:(NSManagedObjectContext*)context forEntity:(NSString*)entity withUniqueAttributeValue:(NSString*)uniqueAttributeValue {
    NSString *uniqueAttribute = [self uniqueAttributeForEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K==%@", uniqueAttribute, uniqueAttributeValue];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entity];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    NSError *error;
    NSArray *fetchRequestResults = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    if (fetchRequestResults.count == 0) {
        return nil;
    }
    return fetchRequestResults.lastObject;
}

#pragma mark 生成持久化对象
- (NSManagedObject*)insertUniqueObjectInTargetEntity:(NSString*)entity uniqueAttributeValue:(NSString*)uniqueAttributeValue attributeValues:(NSDictionary*)attributeValues inContext:(NSManagedObjectContext*)context {
    NSString *uniqueAttribute = [self uniqueAttributeForEntity:entity];
    if (uniqueAttributeValue.length > 0) {
        NSManagedObject *existingObject = [self existingObjectInContext:context forEntity:entity withUniqueAttributeValue:uniqueAttributeValue];
        // 已存在则不再导入重复数据
        if (existingObject) {
            NSLog(@"%@ 对象包含 %@  '%@' 已经存在", entity, uniqueAttribute, uniqueAttributeValue);
            return existingObject;
        } else {
            NSManagedObject *newObject = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:context];
            [newObject setValuesForKeysWithDictionary:attributeValues];
            NSLog(@"创建 %@ 对象包含 %@ '%@'", entity, uniqueAttribute, uniqueAttributeValue);
            return newObject;
        }
    } else {
        NSLog(@"跳过%@对象创建：属性长度为0", entity);
    }
    return nil;
}

#pragma mark - 深拷贝
#pragma mark 对实体执行深拷贝
- (void)deepCopyEntities:(NSArray *)entities fromContext:(NSManagedObjectContext *)sourceContext toContext:(NSManagedObjectContext *)targetContext {
    for (NSString *entity in entities) {
        NSLog(@"拷贝对象%@到目标上下文中...", entity);
        NSArray *sourceObjects = [self arrayForEntity:entity inContext:sourceContext withPredicate:nil];
        for (NSManagedObject *sourceObject in sourceObjects) {
            if (sourceObject) {
                // 内存管理池，运行完毕销毁数据
                @autoreleasepool {
                    // 拷贝对象
                    [self copyUniqueObject:sourceObject toContext:targetContext];
                    // 拷贝关系
                    [self copyRelationshipsFromObject:sourceObject toContext:targetContext];
                }
            }
        }
    }
}

#pragma mark 根据给定的实体、上下文和谓词返回含有托管对象的数组
- (NSArray *)arrayForEntity:(NSString* )entity inContext:(NSManagedObjectContext *)context withPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity];
    [request setFetchBatchSize:15];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"抓取对象出错: %@", error.localizedDescription);
    }
    return array;
}


#pragma mark 返回包含NSManagedObject对象信息的NSString
- (NSString *)objectInfo:(NSManagedObject *)object {
    if (!object) {
        return nil;
    }
    NSString *entity = object.entity.name;
    NSString *uniqueAttribute = [self uniqueAttributeForEntity:entity];
    NSString *uniqueAttributeValue = [object valueForKey:uniqueAttribute];
    
    return [NSString stringWithFormat:@"%@ '%@'", entity, uniqueAttributeValue];
}

#pragma mark 把对象拷贝到给定的上下文之中，并确保每个对象只拷贝一次
- (NSManagedObject *)copyUniqueObject:(NSManagedObject *)object toContext:(NSManagedObjectContext *)targetContext {
    // 数据不存在时，跳过复制
    if (!object || !targetContext) {
        NSLog(@"复制%@到上下文%@失败", [self objectInfo:object], targetContext);
        return nil;
    }
    
    // 准备变量
    NSString *entity = object.entity.name;
    NSString *uniqueAttribute = [self uniqueAttributeForEntity:entity];
    NSString *uniqueAttributeValue = [object valueForKey:uniqueAttribute];
    
    if (uniqueAttributeValue.length  > 0)  {
        
        // 准备复制属性
        NSMutableDictionary *attributeValuesToCopy = [NSMutableDictionary new];
        for (NSString *attribute in object.entity.attributesByName)
        {
            [attributeValuesToCopy setValue:[[object valueForKey:attribute] copy] forKey:attribute];
        }
        
        // 复制对象
        NSManagedObject *copiedObject = [self insertUniqueObjectInTargetEntity:entity uniqueAttributeValue:uniqueAttributeValue  attributeValues:attributeValuesToCopy inContext:targetContext];
        
        // 更新修改日期
        if ([[[copiedObject entity] attributesByName] objectForKey:@"modified"]) {
            [copiedObject setValue:[NSDate date] forKey:@"modified"];
        }
        
        return copiedObject;
    }
    return nil;
}

#pragma mark 拷贝关系
- (void)copyRelationshipsFromObject:(NSManagedObject *)sourceObject toContext:(NSManagedObjectContext *)targetContext {
    // 数据不存在时，跳过建立关系
    if (!sourceObject || !targetContext) {
        NSLog(@"跳过从'%@'复制关系到上下文'%@'中", [self objectInfo:sourceObject], targetContext);
        return;
    }
    
    // 对象不存在跳过建立关系
    NSManagedObject *copiedObject = [self copyUniqueObject:sourceObject toContext:targetContext];
    if (!copiedObject) {
        return;
    }
    
    // 复制关系
    NSDictionary *relationships = [sourceObject.entity relationshipsByName];
    for (NSString *relationshipName in relationships) {
        NSRelationshipDescription *relationship = [relationships objectForKey:relationshipName];
        if ([sourceObject valueForKey:relationshipName]) {
            // 建立一对多关系
            if (relationship.isToMany) {
                // 有序
                if (relationship.isOrdered) {
                    NSMutableOrderedSet *sourceSet = [sourceObject mutableOrderedSetValueForKey:relationshipName];
                    [self establishOrderedToManyRelationship:relationshipName fromObject:copiedObject withSourceSet:sourceSet];
                } else { // 无序
                    NSMutableSet *sourceSet = [sourceObject mutableSetValueForKey:relationshipName];
                    [self establishToManyRelationship:relationshipName fromObject:copiedObject withSourceSet:sourceSet];
                }
            } else { // 建立一对一关系
                NSManagedObject *relatedSourceObject = [sourceObject valueForKey:relationshipName];
                NSManagedObject *relatedCopiedObject = [self copyUniqueObject:relatedSourceObject toContext:targetContext];
                [self establishToOneRelationship:relationshipName fromObject:copiedObject toObject:relatedCopiedObject];
            }
        }
    }
}

#pragma mark 建立一对一的关系
- (void)establishToOneRelationship:(NSString *)relationshipName fromObject:(NSManagedObject *)object toObject:(NSManagedObject *)relatedObject {
    // 数据不存在时，跳过建立关系
    if (!relationshipName || !object || !relatedObject) {
        NSLog(@"由于缺少信息，跳过在%@和%@之间建立一对一的关系'%@'", relationshipName, [self objectInfo:object], [self objectInfo:relatedObject]);
        return;
    }
    
    // 关系已存在时，跳过建立关系
    NSManagedObject *existingRelatedObject = [object valueForKey:relationshipName];
    if (existingRelatedObject) {
        return;
    }
    
    // 实体错误时，跳过建立关系
    NSDictionary *relationships = [object.entity relationshipsByName];
    NSRelationshipDescription *relationship = [relationships objectForKey:relationshipName];
    if (![relatedObject.entity isEqual:relationship.destinationEntity]) {
        NSLog(@"实体%@错误，无法和%@建立关系", [self objectInfo:object], [self objectInfo:relatedObject]);
        return;
    }
    // 建立关系
    [object setValue:relatedObject forKey:relationshipName];
    NSLog(@"从%@到%@建立关系：%@", [self objectInfo:object], [self objectInfo:relatedObject], relationshipName);
    
    // 存储到磁盘后，从内存中去掉关系
    [YJCDFaulter faultObjectWithID:object.objectID inContext:object.managedObjectContext];
    [YJCDFaulter faultObjectWithID:relatedObject.objectID inContext:object.managedObjectContext];
}

#pragma mark 建立一对多关系
- (void)establishToManyRelationship:(NSString *)relationshipName fromObject:(NSManagedObject *)object  withSourceSet:(NSMutableSet *)sourceSet {
    if (!object || !sourceSet || !relationshipName) {
        NSLog(@"由于缺少信息，跳过在%@中建立一对多的关系", [self objectInfo:object]);
        return;
    }
    
    NSMutableSet *copiedSet = [object mutableSetValueForKey:relationshipName];
    for (NSManagedObject *relatedObject in sourceSet)
    {
        NSManagedObject *copiedRelatedObject = [self copyUniqueObject:relatedObject  toContext:object.managedObjectContext];
        if (copiedRelatedObject)
        {
            [copiedSet addObject:copiedRelatedObject];
            NSLog(@"从%@到%@建立一对多的关系：%@", [self objectInfo:object], [self objectInfo:copiedRelatedObject], relationshipName);
        }
    }
    // 存储到持久化存储区后，从内存中去掉关系
    [YJCDFaulter faultObjectWithID:object.objectID inContext:object.managedObjectContext];
}

#pragma mark 建立有序的一对多关系
- (void)establishOrderedToManyRelationship:(NSString *)relationshipName fromObject:(NSManagedObject *)object withSourceSet:(NSMutableOrderedSet *)sourceSet {
    if (!object || !sourceSet || !relationshipName) {
        NSLog(@"由于缺少信息，跳过在%@中建立有序的一对多关系",
              [self objectInfo:object]);
        return;
    }
    
    NSMutableOrderedSet *copiedSet = [object mutableOrderedSetValueForKey:relationshipName];
    for (NSManagedObject *relatedObject in sourceSet) {
        NSManagedObject *copiedRelatedObject = [self copyUniqueObject:relatedObject toContext:object.managedObjectContext];
        if (copiedRelatedObject)
        {
            [copiedSet addObject:copiedRelatedObject];
            NSLog(@"从%@到%@建立有序的一对多关系：%@", [self objectInfo:object], [self objectInfo:copiedRelatedObject], relationshipName);
        }
    }
    
    // 存储到持久化存储区后，从内存中去掉关系
    [YJCDFaulter faultObjectWithID:object.objectID inContext:object.managedObjectContext];
}

@end
