//
//  YJNSFileManager.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (YJNSFileManager)

#pragma mark 创建目录

/**
 *  @abstract 创建目录
 *  @discusstion 已创建则不会创建
 *
 *  @param path  目标地址
 *  @param error 错误信息
 *
 *  @return BOOL
 */
- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError **)error;

/**
 *  @abstract 创建目录
 *  @discusstion 已创建则不会创建
 *
 *  @param url   NSURL目标地址
 *  @param error 错误信息
 *
 *  @return BOOL
 */
- (BOOL)createDirectoryAtURL:(NSURL *)url error:(NSError **)error;

#pragma mark 替换

/**
 *  @abstract ⌘+c -> ⌘+v
 *  @discusstion 目标地址存在则替换
 *
 *  @param srcPath 源地址
 *  @param dstPath 目标地址
 *
 *  @return BOOL
 */
- (BOOL)replaceItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;

/**
 *  @abstract ⌘+c -> ⌘+v
 *  @discusstion 目标地址存在则替换
 *
 *  @param srcURL 源地址
 *  @param dstURL 目标地址
 *
 *  @return BOOL
 */
- (BOOL)replaceItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END

