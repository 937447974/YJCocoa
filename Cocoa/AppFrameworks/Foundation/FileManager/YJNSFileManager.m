//
//  YJNSFileManager.m
//  YJFoundation
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/25.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSFileManager.h"

@implementation NSFileManager (YJNSFileManager)

- (BOOL)moveSafeItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError *__autoreleasing *)error {
    return [self moveSafeItemAtURL:[NSURL fileURLWithPath:srcPath] toURL:[NSURL fileURLWithPath:dstPath] error:error];
}

- (BOOL)moveSafeItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError *__autoreleasing *)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = YES;
    NSURL *dstDirectory = dstURL.URLByDeletingLastPathComponent;
    if ([fileManager fileExistsAtPath:dstDirectory.path]) {
        if ([fileManager fileExistsAtPath:dstURL.path]) {
            result = [fileManager removeItemAtURL:dstURL error:error];
        }
    } else {
        result = [fileManager createDirectoryAtURL:dstDirectory withIntermediateDirectories:YES attributes:nil error:error];
    }
    if (result) {
        result = [fileManager moveItemAtURL:srcURL toURL:dstURL error:error];
    }
    return result;
}

@end
