//
//  YJSDictionaryModelProperty.h
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
typedef NS_ENUM(NSInteger, YJSDMPAttributeClass) {
    YJSDMPAttributeClassNumber,     ///< NSNumber
    YJSDMPAttributeClassString,     ///< NSString
    YJSDMPAttributeClassArray,      ///< NSArray
    YJSDMPAttributeClassDictionary, ///< NSDictionary
    YJSDMPAttributeClassModel       ///< Model
};

/** 模型中的属性*/
@interface YJSDictionaryModelProperty : NSObject

@property (nonatomic, copy) NSString *attributeName; ///< 属性名
@property (nonatomic, copy) NSString *attributeKey;  ///< 属性对应字典中的Key

@property (nonatomic) YJSDMPAttributeClass attributeClass; ///< 属性对应的class
@property (nonatomic, nullable) NSString *attributeClassName;  ///< 属性对应的class名

@property (nonatomic)           BOOL importArrayClassSystem; ///< YJSDMPAttributeClassArray模式下填充的Class是否系统基础类型
@property (nonatomic, nullable) Class importArrayClassName;  ///< YJSDMPAttributeClassArray模式下填充的Class，即NSArray<importArrayClassName *> *attributeName;

@end

NS_ASSUME_NONNULL_END
