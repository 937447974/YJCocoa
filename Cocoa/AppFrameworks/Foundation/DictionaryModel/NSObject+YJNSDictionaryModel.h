//
//  NSObject+YJNSDictionaryModel.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/9/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSDictionaryModelManager.h"

NS_ASSUME_NONNULL_BEGIN

/** 模型和字典互相转换*/
@interface NSObject (YJNSDictionaryModel)

@property (nonatomic, strong, readonly) NSDictionary *modelDictionary; ///< 模型字典

/**
 *  @abstract 获取DictionaryModel转换管理器
 *  @discusstion 可通过此控制器配置转换相关设置，子类重写
 *
 *  @return YJNSDictionaryModelManager
 */
+ (YJNSDictionaryModelManager *)dictionaryModelManager;

/**
 *  @abstract 根据模型字典生成对象
 *  @discusstion readonly和weak属性会自动跳过
 *
 *  @param modelDictionary 模型字典
 *
 *  @return instancetype
 */
- (instancetype)initWithModelDictionary:(NSDictionary *)modelDictionary;

#pragma mark - Compatible

/**
 *  @abstract 类转换为模型字典
 *  @discusstion 在 dictionaryModelManager 的基础上定制属性对应关系
 *
 *  @param optionalAttributes YJNSDictionaryModelManager.optionalAttributes属性
 *
 *  @return 模型字典
 */
- (NSDictionary *)modelDictionaryWithOptionalAttributes:(NSDictionary<NSString *, NSString *> *)optionalAttributes;

/**
 *  @abstract 模型字典转换为类
 *  @discusstion 在 dictionaryModelManager 的基础上定制属性对应关系
 *
 *  @param modelDictionary 模型字典
 *  @param optionalAttributes YJNSDictionaryModelManager.optionalAttributes属性
 *
 *  @return 模型字典
 */
- (instancetype)initWithModelDictionary:(NSDictionary *)modelDictionary optionalAttributes:(NSDictionary<NSString *, NSString *> *)optionalAttributes;

@end

NS_ASSUME_NONNULL_END
