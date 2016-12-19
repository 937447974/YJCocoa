//
//  YJNSHttpAnalysis.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** http链接解析参数*/
@interface YJNSHttpAnalysis : NSObject

/**
 *  @abstract 通过http链接获取对应的参数
 *
 *  @param http http链接
 *
 *  @return NSMutableDictionary
 */
+ (NSDictionary<NSString *, NSString *> *)analysisParams:(NSString *)http;

/**
 *  @abstract 通过http链接获取对应的参数(value会urlDecode解码)
 *
 *  @param http http链接
 *
 *  @return void
 */
+ (NSDictionary<NSString *, NSString *> *)analysisParamsDecode:(NSString *)http;

/**
 *  @abstract 通过http链接和参数key获取对应的参数获取对应的参数
 *
 *  @param http http链接
 *  @param key  参数对应的key
 *
 *  @return NSString
 */
+ (nullable NSString *)analysisParams:(NSString *)http forKey:(NSString *)key;

/**
 *  @abstract 通过http链接和参数key获取对应的参数获取对应的参数(value会urlDecode解码)
 *
 *  @param http http链接
 *  @param key  参数对应的key
 *
 *  @return NSString
 */
+ (nullable NSString *)analysisParamsDecode:(NSString *)http forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
