//
//  YJNSDictionaryModelManager.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/9/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** DictionaryModel转换管理器*/
@interface YJNSDictionaryModelManager : NSObject

/**
 *  @abstract 配置属性对应字典中的key
 *  @discusstion 如属性名为userID,对应字典中的key为user_id,则需通过此方法修改
 *
 *  @return NSDictionary<属性名, modelDictionary中的key> *
 */
@property (nonatomic, strong, nullable) NSDictionary<NSString *, NSString *> *optionalAttributes;

/**
 *  @abstract 忽略的属性集合
 *
 *  @return NSArray<NSString *> *
 */
@property (nonatomic, strong, nullable) NSSet<NSString *> *ignoredAttributes;

/**
 *  @abstract 配置数组属性中存放的是自定义的类
 *  @discusstion 如果数组属性中存放的是自定义的类如property NSArray<importArrayClass *> *attributeName，则需通过此方法返回importArrayClass
 *
 *  @return NSDictionary<属性名, modelDictionary中的key> *
 */
@property (nonatomic, strong, nullable) NSDictionary<NSString *, Class> *importArrayClasses;

@property (nonatomic, strong, readonly) NSSet<Class> *systemBaseClass; ///< 系统基类

@end

NS_ASSUME_NONNULL_END
