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

/**
 *  @abstract 安全的移动文件
 *  @discusstion 替换moveItemAtPath:toPath:error:方法
 *
 *  @param srcPath 源地址
 *  @param dstPath 目标地址
 *
 *  @return BOOL
 */
- (BOOL)moveSafeItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError * _Nullable *)error;

/**
 *  @abstract 安全的移动文件
 *  @discusstion 替换moveItemAtURL:toURL:error:方法
 *
 *  @param srcURL 源地址
 *  @param dstURL 目标地址
 *
 *  @return BOOL
 */
- (BOOL)moveSafeItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError * _Nullable *)error;

@end

NS_ASSUME_NONNULL_END

