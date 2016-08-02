//
//  YJKeychainItem.h
//  YJSecurity
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/8/1.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

NS_ASSUME_NONNULL_BEGIN

/** YJKeychainItem的携带属性*/
@protocol YJKItemAttribute <NSObject>

@optional

@property (nonatomic)           NSString *accessible;  ///< 可访问性
@property (nonatomic)           NSString *accessGroup; ///< 访问组
@property (nonatomic, nullable) NSString *label;       ///< 标签

@end


/** kSecClassGenericPassword携带属性*/
@protocol YJKItemGenericPasswordAttribute <YJKItemAttribute>

@optional

@property (nonatomic, readonly) NSDate *createDate;  ///< 创建日期
@property (nonatomic, readonly) NSDate *modifyDate;  ///< 最后一次修改日期
@property (nonatomic, nullable) NSString *desc;      ///< 描述
@property (nonatomic, nullable) NSString *comment;   ///< 注释
@property (nonatomic, nullable) NSNumber *creator;   ///< 创造者
@property (nonatomic, nullable) NSNumber *type;      ///< 类型
@property (nonatomic)           Boolean isInvisible; ///< 是否隐藏
@property (nonatomic)           Boolean isNegative;  ///< 是否具有密码
@property (nonatomic, nullable) NSString *account;   ///< 账号
@property (nonatomic, nullable) NSString *service;   ///< 所具有服务
@property (nonatomic, nullable) NSData *generic;     ///< 用户自定义内容

@end


/** Keychain存放的item基类*/
@interface YJKeychainItem : NSObject

// 框架使用,外部不建议使用
@property (nonatomic, strong) NSDictionary *matchingDict;    ///< 查询字典
@property (nonatomic, strong) NSMutableDictionary *saveDict; ///< 持久化字典

@end

NS_ASSUME_NONNULL_END
