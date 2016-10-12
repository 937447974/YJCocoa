//
//  YJNSDirectory.h
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/12.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSSingletonMCenter.h"

NS_ASSUME_NONNULL_BEGIN

// 快速通过单例获取目录
#define YJNSDirectoryS ((YJNSDirectory *)[YJNSSingletonMC registerWeakSingleton:[YJNSDirectory class]])

/** 应用内目录*/
@interface YJNSDirectory : NSObject

#pragma mark path路径
@property (nonatomic, copy, readonly) NSString *homePath;     ///< HomeDirectoryPath
@property (nonatomic, copy, readonly) NSString *documentPath; ///< DocumentDirectoryPath
@property (nonatomic, copy, readonly) NSString *libraryPath;  ///< LibraryDirectoryPath
@property (nonatomic, copy, readonly) NSString *cachesPath;   ///< CachesDirectoryPath
@property (nonatomic, copy, readonly) NSString *tempPath;     ///< TemporaryDirectoryPath

#pragma mark url路径
@property (nonatomic, strong, readonly) NSURL *homeURL;     ///< HomeDirectoryURL
@property (nonatomic, strong, readonly) NSURL *documentURL; ///< DocumentDirectoryURL
@property (nonatomic, strong, readonly) NSURL *libraryURL;  ///< LibraryDirectoryURL
@property (nonatomic, strong, readonly) NSURL *cachesURL;   ///< CachesDirectoryURL
@property (nonatomic, strong, readonly) NSURL *tempURL;     ///< TemporaryDirectoryURL

@end

NS_ASSUME_NONNULL_END
