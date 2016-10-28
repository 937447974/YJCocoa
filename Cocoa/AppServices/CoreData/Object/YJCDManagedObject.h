//
//  YJCDManagedObject.h
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

/** NSManagedObject扩展*/
@interface NSManagedObject (YJCDManagedObject)

/**
 *  @abstract 插入新的NSManagedObject
 *
 *  @return instancetype
 */
+ (instancetype)insertNewObject;

/**
 *  @abstract 获取Select查询
 *  @discusstion 实现iOS10的方法
 *
 *  @return NSFetchRequest
 */
+ (NSFetchRequest<NSManagedObject *> *)fetchRequest;

@end

NS_ASSUME_NONNULL_END
