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

- (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    return [self createDirectoryAtURL:[NSURL URLWithString:path] error:error];
}

- (BOOL)createDirectoryAtURL:(NSURL *)url error:(NSError *__autoreleasing *)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:url.path]) {
        return YES;
    }
    return [fileManager createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:error];
}

- (BOOL)replaceItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError *__autoreleasing *)error {
    return [self replaceItemAtURL:[NSURL URLWithString:srcPath] toURL:[NSURL URLWithString:dstPath] error:error];
}

- (BOOL)replaceItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError *__autoreleasing *)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:dstURL.path]) {
        [fileManager removeItemAtURL:dstURL error:error];
    }
    if (!error) {
        return [fileManager moveItemAtURL:srcURL toURL:dstURL error:error];
    }
    return NO;
}

@end
