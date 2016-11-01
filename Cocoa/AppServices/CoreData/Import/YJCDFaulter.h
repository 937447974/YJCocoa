//
//  YJCDFaulter.h
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/31.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

/** 将对象转化为fault*/
@interface YJCDFaulter : NSObject

/**
 *  根据给定的objectID把相关对象转化为fault
 *
 *  @param objectID 对象id
 *  @param context  上下文
 */
+ (void)faultObjectWithID:(NSManagedObjectID *)objectID inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END
