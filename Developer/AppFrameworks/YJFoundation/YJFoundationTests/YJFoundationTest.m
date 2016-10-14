//
//  YJFoundationTest.m
//  YJFoundation
//
//  Created by admin on 2016/10/12.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJFoundation.h"

@interface YJFoundationTest : XCTestCase

@end

@implementation YJFoundationTest

- (void)testExample {
    NSLog(@"应用沙盒根路径:%@", YJNSDirectoryS.homePath);
    NSLog(@"Documents目录:%@", YJNSDirectoryS.documentPath);
    NSLog(@"Library目录:%@", YJNSDirectoryS.libraryPath);
    NSLog(@"Cache目录:%@", YJNSDirectoryS.cachesPath);
    NSLog(@"Temp目录:%@", YJNSDirectoryS.tempPath);
    
//    NSFileManager *m = [NSFileManager defaultManager];
//    NSLog(@"%@", [m subpathsOfDirectoryAtPath:YJNSDirectoryS.homePath error:nil]);
//    NSLog(@"%@", [m componentsToDisplayForPath:YJNSDirectoryS.homePath]);
//    NSLog(@"%@", [m displayNameAtPath:YJNSDirectoryS.cachesPath]);
//    NSLog(@"%@", [m attributesOfItemAtPath:YJNSDirectoryS.cachesPath error:nil]);
//    NSLog(@"%@", [m attributesOfFileSystemForPath:YJNSDirectoryS.cachesPath error:nil]);
//    NSLog(@"%d", [m contentsEqualAtPath:YJNSDirectoryS.cachesPath andPath:YJNSDirectoryS.cachesPath]);
//    NSLog(@"%s", [m fileSystemRepresentationWithPath:YJNSDirectoryS.cachesPath]);
//    NSLog(@"%@", [m stringWithFileSystemRepresentation:[m fileSystemRepresentationWithPath:YJNSDirectoryS.cachesPath] length:YJNSDirectoryS.cachesPath.length]);
//    NSLog(@"%@", [m currentDirectoryPath]);
    
    NSPointerArray *weakTargets = [NSPointerArray weakObjectsPointerArray];
    [weakTargets addPointer:nil];
    NSString *str = @"22";
    [weakTargets addPointer:(__bridge void * _Nullable)str];
    NSLogS(weakTargets.allObjects);
    for (id item in weakTargets) {
        NSLogS(item);
    }
    [weakTargets compact];
    for (NSInteger index = 0; index < weakTargets.count; index++) {
        if ([str isEqual:[weakTargets pointerAtIndex:index]]) {
            [weakTargets removePointerAtIndex:index];
        }
    }
    
    for (id item in weakTargets) {
        NSLogS(item);
    }
    NSLogS(weakTargets.allObjects);
}

@end
