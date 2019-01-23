//
//  YJSecKeychainItem.h
//  YJSecSecurity
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
@protocol YJSecKItemAttribute <NSObject>

@optional

@property (nonatomic, copy)           NSString *accessGroup; ///< 访问组，支持搜索
@property (nonatomic, copy, readonly) NSString *kClass;      ///< 存储类型，支持搜索
@property (nonatomic, copy)           NSString *accessible;  ///< 可访问性
@property (nonatomic, copy, nullable) NSString *label;       ///< 标签

@end


/** kSecClassGenericPassword携带属性*/
@protocol YJSecKItemGenericPasswordAttribute <YJSecKItemAttribute>

@optional

@property (nonatomic, copy)             NSString *account;   ///< 账号，支持搜索
@property (nonatomic, strong, readonly) NSDate *createDate;  ///< 创建日期
@property (nonatomic, strong, readonly) NSDate *modifyDate;  ///< 最后一次修改日期
@property (nonatomic, copy, nullable)   NSString *desc;      ///< 描述
@property (nonatomic, copy, nullable)   NSString *comment;   ///< 注释
@property (nonatomic, strong, nullable) NSNumber *creator;   ///< 创造者
@property (nonatomic, strong, nullable) NSNumber *type;      ///< 类型
@property (nonatomic)                   Boolean isInvisible; ///< 是否隐藏
@property (nonatomic)                   Boolean isNegative;  ///< 是否具有密码
@property (nonatomic, copy, nullable)   NSString *service;   ///< 所具有服务
@property (nonatomic, strong, nullable) NSData *generic;     ///< 用户自定义内容

@end


/** Keychain存放item的抽象基类*/
@interface YJSecKeychainItem : NSObject

// 框架使用,外部不建议使用
@property (nonatomic, strong) NSMutableDictionary *selectDict; ///< 查询字典
@property (nonatomic, strong) NSMutableDictionary *weakDict;   ///< 缓存字典
@property (nonatomic, strong) NSMutableDictionary *strongDict; ///< 持久化字典

@end

NS_ASSUME_NONNULL_END
