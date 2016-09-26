//
//  NSObject+YJSDictionaryModel.h
//  YJSFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/9/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YJSDictionaryModel)

/**
 *  @abstract 获取属性对应字典中的key
 *  @discusstion 如属性名为userID,对应字典中的key为user_id,则需通过此方法修改
 *
 *  @param attributeName 属性名
 *
 *  @return NSString
 */
+ (NSString *)getDictKeyWithAttributeName:(NSString *)attributeName;

/**
 *  @abstract 获取Model中的属性是@property ... NSArray<importArrayClass *> *attributeName的importArrayClass
 *
 *  @param attributeName 属性名
 *
 *  @return NSString/Model
 */
+ (Class)getImportArrayClassWithAttributeName:(NSString *)attributeName;

/**
 *  @abstract 忽略的属性集合
 *
 *  @return NSArray<NSString *> *
 */
+ (NSSet<NSString *> *)ignoredAttributes;

/**
 *  @abstract 根据NSDictionary生成对象
 *
 *  @param dict 数据字典
 *
 *  @return instancetype
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
