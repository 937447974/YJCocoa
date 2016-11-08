//
//  YJNSDictionaryModelProperty.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/9/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 支持的属性类型*/
typedef NS_ENUM(NSInteger, YJNSDMPAttributeType) {
    YJNSDMPAttributeTypeNumber,     ///< NSNumber
    YJNSDMPAttributeTypeString,     ///< NSString
    YJNSDMPAttributeTypeURL,        ///< NSURL 
    YJNSDMPAttributeTypeArray,      ///< NSArray
    YJNSDMPAttributeTypeDictionary, ///< NSDictionary
    YJNSDMPAttributeTypeModel       ///< Model
};

/** 模型中的属性*/
@interface YJNSDictionaryModelProperty : NSObject

@property (nonatomic, copy) NSString *attributeName; ///< 属性名
@property (nonatomic, copy) NSString *attributeKey;  ///< 属性对应字典中的Key

@property (nonatomic)           YJNSDMPAttributeType attributeType; ///< 属性对应的class类型
@property (nonatomic, nullable) Class attributeClass;              ///< 属性对应的class

@property (nonatomic)           BOOL importArrayClassSystem; ///< importArrayClass是否为系统基础类型
@property (nonatomic, nullable) Class importArrayClass;      ///< @property ... NSArray<importArrayClass *> *attributeName;

@end

NS_ASSUME_NONNULL_END
