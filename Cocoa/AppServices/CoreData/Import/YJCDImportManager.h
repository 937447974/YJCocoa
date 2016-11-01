//
//  YJCDImportManager.h
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

/** 导入SQLite数据*/
@interface YJCDImportManager : NSObject

/**
 *  @abstract 唯一字段<NSManagedObject, 唯一的字段名>
 *  @discusstion 主要用于避免导入重复数据
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *entitiesWithUniqueAttributes;
@property (nonatomic, strong) NSArray<NSString *> *entities; ///< 需要导入的实体类,默认全部导入
@property (nonatomic, strong) NSManagedObjectContext *targetContext; ///< 导入的目标托管对象上下文，默认YJCDManagerS.rootContext

@property (nonatomic, copy) void (^ importProgress)(float progress); ///< 导入的进度[0,1]

@property (nonatomic, strong, nullable) NSError *importError; ///< 导入失败时的错误信息

/**
 *  @abstract 导入SQLite数据
 *  @discusstion 会堵塞线程，建议后台执行
 *
 *  @param storeURL 数据库地址
 *
 *  @return BOOL
 */
- (BOOL)importWithStoreURL:(NSURL *)storeURL;

@end

NS_ASSUME_NONNULL_END
